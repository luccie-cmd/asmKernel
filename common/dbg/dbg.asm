global dbgPuts
global dbgPrintf
extern stbsp_vsnprintf
section .text
dbgPuts:
    push rdi
    jmp .condition
.loop:
    out 0xE9, al
    inc rdi
.condition:
    movzx rax, BYTE [rdi]
    cmp rax, 0
    jne .loop
    pop rdi
    ret

dbgPrintf:
    mov [frameBuffer], rax
    mov [frameBuffer+8], rbx
    mov [frameBuffer+16], rcx
    mov [frameBuffer+24], rdx
    mov [frameBuffer+32], rdi
    mov [frameBuffer+40], rsi
    mov [frameBuffer+48], r8
    mov [frameBuffer+56], r9
    mov [frameBuffer+64], r10
    mov [frameBuffer+72], r11
    mov [frameBuffer+80], r12
    mov [frameBuffer+88], r13
    mov [frameBuffer+96], r14
    mov [frameBuffer+104], r15
    sub rsp, 88
    mov QWORD [rsp+48], rdx
    lea rdx, [rsp+32]
    lea rax, [rsp+96]
    mov QWORD [rsp+56], rcx
    lea rcx, [rsp+8]
    mov QWORD [rsp+40], rsi
    mov QWORD [rsp+24], rdx
    mov esi, 8192
    mov rdx, rdi
    mov rdi, buffer
    mov QWORD [rsp+64], r8
    mov QWORD [rsp+72], r9
    mov DWORD [rsp+8], 8
    mov QWORD [rsp+16], rax
    call stbsp_vsnprintf
    mov rdi, buffer
    call dbgPuts
    add rsp, 88
    mov rax, [frameBuffer]
    mov rbx, [frameBuffer+8]
    mov rcx, [frameBuffer+16]
    mov rdx, [frameBuffer+24]
    mov rdi, [frameBuffer+32]
    mov rsi, [frameBuffer+40]
    mov r8,  [frameBuffer+48]
    mov r9,  [frameBuffer+56]
    mov r10, [frameBuffer+64]
    mov r11, [frameBuffer+72]
    mov r12, [frameBuffer+80]
    mov r13, [frameBuffer+88]
    mov r14, [frameBuffer+96]
    mov r15, [frameBuffer+104]
    ret

section .bss
buffer:
    resb 8192
frameBuffer:
    resq 14