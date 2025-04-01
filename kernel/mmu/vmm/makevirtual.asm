global vmmMakeVirtual
extern hhdmOffset
section .text
vmmMakeVirtual:
    mov rax, rdi
    add rax, [hhdmOffset]
    ret