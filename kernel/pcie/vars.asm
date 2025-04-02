global usePciOld
global pcieSegmentBases
global pcieSegmentCount
global pciDevices
global pciDevicesCount
section .bss
usePciOld: resb 1
pcieSegmentCount: resb 1
pcieSegmentBases: resq 16
pciDevices: resq 1
pciDevicesCount: resq 1