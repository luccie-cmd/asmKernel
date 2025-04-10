global PCIreadConfigByte
global PCIreadConfigWord
global PCIreadConfig
extern usePciOld
extern dbgPrintf
extern pcieSegmentBases
extern abort
section .text
PCIreadConfigByte:
    call PCIreadConfig
    movzx rax, al
    ret

PCIreadConfigWord:
    call PCIreadConfig
    movzx rax, ax
    ret

; rdi: segment
; rsi: bus
; rdx: device
; rcx: function
; r8: offset
PCIreadConfig:
    movzx rax, BYTE [usePciOld]
    test rax, rax
    jz .new
.old:
    mov rdi, str0
    call dbgPrintf
    call abort
.new:
    prefetchnta [pcieSegmentBases]
    push r15
    shl rdi, 4
    lea r15, pcieSegmentBases
    add r15, rdi
    shr rdi, 4
    mov r15, [r15]
    push rsi
    shl rsi, 20
    shl rdx, 15
    shl rcx, 12
    or rsi, rdx
    or rsi, rcx
    shr rcx, 12
    shr rdx, 15
    add r15, rsi
    pop rsi
    add r15, r8
    mov rax, QWORD [r15]
    pop r15
    ret

section .rodata
str0: db "TODO: Old PCI config reading", 0x0a, 0