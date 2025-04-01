global abort
extern dbgPuts
section .text
abort:
    mov rdi, str0
    call dbgPuts
.hcf:
    cli
    hlt
    jmp .hcf

section .rodata
str0: db "ABORTING KERNEL", 0x0a, 0