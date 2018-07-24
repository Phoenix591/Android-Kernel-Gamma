# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Gamma Kernel for the LG V20
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=elsa
device.name2=omni_ls997
device.name3=ls997
device.name4=LG-LS997
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

if [ -f "init.rc" ]; then
  ui_print "Applying kernel parameter changes";
  insert_line "init.rc" "init.kernel.params.rc" before "import /init.environ.rc" "import /init.msm8996.rc";
  insert_line "init.rc" "init.kernel.params.rc" before "import /init.environ.rc" "import /init.kernel.params.rc";
fi

# end ramdisk changes

write_boot;

## end install

## system specific modifications

ui_print "Enabling discard and trimming internal storage before reboot";
mount /data   ; fstrim /data   && umount /data;
mount /cache  ; fstrim /cache  && umount /cache;
tune2fs -o discard /dev/block/bootdevice/by-name/userdata;
tune2fs -o discard /dev/block/bootdevice/by-name/cache;

exit 0;

