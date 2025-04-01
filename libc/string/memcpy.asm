global memcpy
section .text
memcpy:
    push rdi
    push rcx
    mov rax, rdi
    xor rcx, rcx
    jmp .condition
.loop:
    mov dil, BYTE [rsi+rcx]
    mov BYTE [rax+rcx], dil
    inc rcx
.condition:
    cmp rcx, rdx
    jl .loop
    pop rcx
    pop rdi
    ret