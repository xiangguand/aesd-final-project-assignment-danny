/*
 * aesd_debug.h
 *
 *  Created on: May 05, 2024
 *      Author: Xiang-Guan Deng
 */

#ifndef AESD_DEBUG_H_
#define AESD_DEBUG_H_

#define AESD_DEBUG 1  //Remove comment on this line to enable debug

#undef PDEBUG             /* undef it, just in case */
#ifdef AESD_DEBUG
#  ifdef __KERNEL__
     /* This one if debugging is on, and kernel space */
#    define PDEBUG(fmt, args...) printk( KERN_DEBUG "aesdchar: " fmt, ## args)
#  else
     /* This one for user space */
#    define PDEBUG(fmt, args...) fprintf(stderr, fmt, ## args)
#  endif
#else
#  define PDEBUG(fmt, args...) /* not debugging: nothing */
#endif


#endif /* AESD_DEBUG_H_ */