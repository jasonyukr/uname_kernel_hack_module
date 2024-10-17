ifdef KERNEL_MODULE
KERNEL_DIR := /lib/modules/$(KERNEL_MODULE)/build
else
PWD := $(shell pwd)
KERNEL_DIR := /lib/modules/$(shell uname -r)/build
endif

obj-m += unamehack.o

ifdef KSYSNAME
EXTRA_CFLAGS += "-Dhack_sysname=\"${KSYSNAME}\""
endif

ifdef KNODENAME
EXTRA_CFLAGS += "-Dhack_nodename=\"${KNODENAME}\""
endif

ifdef KRELEASE
EXTRA_CFLAGS += "-Dhack_release=\"${KRELEASE}\""
endif

ifdef KVERSION
EXTRA_CFLAGS += "-Dhack_version=\"${KVERSION}\""
endif

ifdef KMACHINE
EXTRA_CFLAGS += "-Dhack_machine=\"${KMACHINE}\""
endif

ifdef KDOMAINNAME
EXTRA_CFLAGS += "-Dhack_domainname=\"${KDOMAINNAME}\""
endif

modules clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) $@

test: modules
	uname -a
	sudo /sbin/insmod unamehack.ko
	uname -a
	sudo /sbin/rmmod unamehack
	uname -a

insertunamemodule: modules
	uname -a
	sudo /sbin/insmod unamehack.ko
	uname -a

removeunamemodule:
	uname -a
	sudo /sbin/rmmod unamehack
	uname -a
