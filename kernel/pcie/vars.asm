global usePciOld
global pcieSegmentBases
global pcieSegmentCount
section .bss
usePciOld: resb 1
pcieSegmentCount: resb 1
pcieSegmentBases: resq 16