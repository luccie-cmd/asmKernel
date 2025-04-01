global halExtInit
extern abort
extern dbgPuts
section .text
halExtInit:
    mov rax, cr0
    and rax, ~(1 << 2)
    or rax, 2
    mov cr0, rax
    mov rax, cr4
    or rax, (1 << 9) | (1 << 10)
    mov cr4, rax
    ret

section .rodata

section .bss