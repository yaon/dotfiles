#include <linux/module.h>
#include <linux/delay.h>
#include <linux/kthread.h>

struct task_struct *kthreadA_id;
struct task_struct *kthreadB_id;

MODULE_DESCRIPTION("kthread2");
MODULE_AUTHOR("Pierre Ficheux, Open Wide");
MODULE_LICENSE("GPL");

static int time = 1;
module_param(time, int, 0644);
MODULE_PARM_DESC(time, "Sleep time");

static int kthread_func (void *data)
{
  int nrun = 0;
  char *s = (char*)data;

  printk (KERN_INFO "kthread %s starting\n", s);

  do {
    ssleep (time);
    nrun++;
    printk (KERN_INFO "kthread %s running %d\n", s, nrun);
  } while (!kthread_should_stop ());

  printk (KERN_INFO "kthread %s exiting\n", s);

  return 0;
}

static int __init kthread2_init(void)
{
  if (!(kthreadA_id = kthread_run (kthread_func, "A", "kthreadA")))
    return -EIO;

  if (!(kthreadB_id = kthread_run (kthread_func, "B", "kthreadB"))) {
    kthread_stop (kthreadA_id);
    return -EIO;
  }

  return 0;
}

static void __exit kthread2_exit(void)
{
  kthread_stop (kthreadA_id);
  kthread_stop (kthreadB_id);
}

module_init (kthread2_init);
module_exit (kthread2_exit);
