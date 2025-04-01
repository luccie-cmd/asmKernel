global memcmp
section .text
memcmp:
    push rdx
    push r8
    push rcx
    test rdx, rdx
    je .L5
    xor eax, eax
    jmp .L4
.L3:
    add rax, 1
    cmp rax, rdx
    je .L5
.L4:
    movzx ecx, BYTE [rdi+rax]
    movzx r8d, BYTE [rsi+rax]
    cmp cl, r8b
    je .L3
    movzx eax, cl
    sub eax, r8d
    pop rcx
    pop r8
    pop rdx
    ret
.L5:
    xor eax, eax
    pop rcx
    pop r8
    pop rdx
    ret