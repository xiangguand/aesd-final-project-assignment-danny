#include <linux/module.h>
#include <linux/init.h>
#include <linux/printk.h>
#include <linux/types.h>
#include <linux/cdev.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/mutex.h>
#include <asm/io.h>
#include <asm/page.h>

#include "bsp_io.h"

int bsp_io_major = 0;
int bsp_io_minor = 0;

static struct bsp_io_dev debug_device = { .is_open_ = false };

MODULE_AUTHOR("Xiang Guan Deng");
MODULE_LICENSE("Dual BSD/GPL");

static void *gpio_base = NULL;

static int bsp_io_open(struct inode *inode, struct file *file)
{
	PDEBUG("===== Open =====\n");
	gpio_base = ioremap(0x3F200000U, 0x1000);
	printk(">>%p\n", gpio_base);
	if (debug_device.is_open_) {
		// device is already open
		return -EBUSY;
	}
	debug_device.is_open_ = true;

	return 0;
}

static ssize_t bsp_io_read(struct file *filp, char __user *buf,
				 size_t count, loff_t *f_pos)
{
	PDEBUG("===== Read =====\n");
	if (!debug_device.is_open_) {
		return -1;
	}
	PDEBUG("read %zu bytes with offset %lld", count, *f_pos);

	return count;
}

static ssize_t bsp_io_write(struct file *filp, const char __user *buf,
				  size_t count, loff_t *f_pos)
{
	PDEBUG("===== Write =====\n");
	if (!debug_device.is_open_) {
		return -1;
	}
	PDEBUG("write %zu bytes with offset %lld", count, *f_pos);
	uint32_t addr, data;
	if (0 == memcmp(buf, "rd", 2)) {
		sscanf(buf, "rd %x\n", &addr);
		PDEBUG("addr = %x\n", addr);
		// void *device_registers = ioremap(addr, 0x10);
		// printk("[%x]: %x\n", addr, readl(device_registers));
		if(addr < 0x100) {
			printk("[%x]: %x\n", 0x3F200000U+addr, *((u32 *)(gpio_base+addr)));
		}
	} else if (0 == memcmp(buf, "wr", 2)) {
		sscanf(buf, "wr %x %x\n", &addr, &data);
		PDEBUG("addr = %x, data = %x\n", addr, data);
		if(addr < 0x100) {
			printk("[%x]: %x\n", 0x3F200000U+addr, *((u32 *)(gpio_base+addr)));
			*((u32 *)(gpio_base+addr)) = data;
			printk("[%x]: %x\n", 0x3F200000U+addr, *((u32 *)(gpio_base+addr)));
		}
	}

	return count;
}

static int bsp_io_release(struct inode *inode, struct file *file)
{
	PDEBUG("release buildroot\n");
	debug_device.is_open_ = false;
	return 0;
}

struct file_operations bsp_io_fops = {
	.owner = THIS_MODULE,
	.open = bsp_io_open,
	.read = bsp_io_read,
	.write = bsp_io_write,
	.release = bsp_io_release,
};

static int setup_bsp_io_cdev(struct bsp_io_dev *dev)
{
	int err, devno = MKDEV(bsp_io_major, bsp_io_minor);

	cdev_init(&dev->cdev, &bsp_io_fops);
	dev->cdev.owner = THIS_MODULE;
	dev->cdev.ops = &bsp_io_fops;

	err = cdev_add(&dev->cdev, devno, 1);
	if (err) {
		printk(KERN_ERR "Error %d adding bsp_io cdev", err);
		return -ENOMEM;
	}

	return 0;
}

/* Device driver init function, create cdev */
static int bsp_io_init(void)
{
	PDEBUG("init buildroot\n");
	dev_t dev = 0;
	int result;
	result = alloc_chrdev_region(&dev, bsp_io_minor, 1,
				     "bsp_io");
	bsp_io_major = MAJOR(dev);
	PDEBUG("bsp_io_major = %d\n", bsp_io_major);
	if (result < 0) {
		printk(KERN_WARNING "Can't get major %d\n", bsp_io_major);
	}
	memset(&debug_device, 0, sizeof(struct bsp_io_dev));

	result = setup_bsp_io_cdev(&debug_device);

	if (result) {
		printk(KERN_WARNING "Can't setup bsp_io cdev\n");
		unregister_chrdev_region(dev, 1);
	}
	PDEBUG("Register dubug_access module successfully");

	return result;
}

static void bsp_io_exit(void)
{
	PDEBUG("exit bsp io module\n");
}

module_init(bsp_io_init);
module_exit(bsp_io_exit);



