if [ "$2" == "release" ]; then
qemu-system-x86_64 \
    -bios /usr/share/OVMF/x64/OVMF.4m.fd \
    -m 2G \
    -debugcon file:debug.log \
    -global isa-debugcon.iobase=0xe9 \
    -no-reboot \
    -d int,cpu_reset \
    -D qemu.log \
    -drive file="$1/image.img",if=none,id=nvme1,format=raw \
    -device nvme,drive=nvme1,serial=deadbeef \
    -cpu qemu64 \
    -M q35 \
    # -enable-kvm
fi