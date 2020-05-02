#!/sbin/sh

touch_class_path=/sys/class/touchscreen
touch_path=
firmware_path=/vendor/firmware
module_path=/sbin/modules

# Load all needed modules
insmod $module_path/aw8695.ko
insmod $module_path/gpio-madera.ko
insmod $module_path/mmi_sys_temp.ko
insmod $module_path/moto_f_usbnet.ko
insmod $module_path/sensors_class.ko
insmod $module_path/goodix_fod_mmi.ko
insmod $module_path/watchdog_cpu_ctx.ko

cd $firmware_path

for touch_product_string in $(ls $touch_class_path); do
    touch_path=/sys$(cat $touch_class_path/$touch_product_string/path)
    firmware_file=$(ls *$touch_product_string*)
    echo 1 > $touch_path/forcereflash
    echo $firmware_file > $touch_path/doreflash
done

return 0
