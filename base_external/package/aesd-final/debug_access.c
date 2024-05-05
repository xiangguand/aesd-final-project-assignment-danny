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

#include "debug_access.h"

int debug_access_major = 0;
int debug_access_minor = 0;

static struct debug_access_dev debug_device = { .is_open_ = false };

MODULE_AUTHOR("Xiang Guan Deng");
MODULE_LICENSE("Dual BSD/GPL");

static void *gpio_base = NULL;

static int debug_access_open(struct inode *inode, struct file *file)
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

static ssize_t debug_access_read(struct file *filp, char __user *buf,
				 size_t count, loff_t *f_pos)
{
	PDEBUG("===== Read =====\n");
	if (!debug_device.is_open_) {
		return -1;
	}
	PDEBUG("read %zu bytes with offset %lld", count, *f_pos);

	return count;
}

static ssize_t debug_access_write(struct file *filp, const char __user *buf,
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

static int debug_access_release(struct inode *inode, struct file *file)
{
	PDEBUG("release buildroot\n");
	debug_device.is_open_ = false;
	return 0;
}

struct file_operations debug_access_fops = {
	.owner = THIS_MODULE,
	.open = debug_access_open,
	.read = debug_access_read,
	.write = debug_access_write,
	.release = debug_access_release,
};

static int setup_debug_access_cdev(struct debug_access_dev *dev)
{
	int err, devno = MKDEV(debug_access_major, debug_access_minor);

	cdev_init(&dev->cdev, &debug_access_fops);
	dev->cdev.owner = THIS_MODULE;
	dev->cdev.ops = &debug_access_fops;

	err = cdev_add(&dev->cdev, devno, 1);
	if (err) {
		printk(KERN_ERR "Error %d adding debug_access cdev", err);
		return -ENOMEM;
	}

	return 0;
}

/* Device driver init function, create cdev */
static int debug_access_init(void)
{
	PDEBUG("init buildroot\n");
	dev_t dev = 0;
	int result;
	result = alloc_chrdev_region(&dev, debug_access_minor, 1,
				     "debug_access");
	debug_access_major = MAJOR(dev);
	PDEBUG("debug_access_major = %d\n", debug_access_major);
	if (result < 0) {
		printk(KERN_WARNING "Can't get major %d\n", debug_access_major);
	}
	memset(&debug_device, 0, sizeof(struct debug_access_dev));

	result = setup_debug_access_cdev(&debug_device);

	if (result) {
		printk(KERN_WARNING "Can't setup debug_access cdev\n");
		unregister_chrdev_region(dev, 1);
	}
	PDEBUG("Register dubug_access module successfully");

	return result;
}

static void debug_access_exit(void)
{
	PDEBUG("exit buildroot\n");
}

module_init(debug_access_init);
module_exit(debug_access_exit);
