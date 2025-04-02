global memset
section .text
memset:
    push rsi
    test rdx, rdx
    je .L7
    sub rsp, 8
    movzx esi, sil
    call memset
    add rsp, 8
    pop rsi
    ret
.L7:
    mov rax, rdi
    pop rsi
    ret