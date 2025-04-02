global pmmAllocatePages
extern pmmHead
extern hhdmOffset
extern dbgPrintf
extern abort
section .text
pmmAllocatePages:
    push rdi
    push rsi
    push rdx
    push rcx
    shl rdi, 12
    mov rdx, rdi
    mov rdi, [pmmHead]
    mov rsi, 0
    jmp .condition
.loop:
    cmp QWORD [rdi], rdx
    jl .nextIteration
    mov rax, rdi
    cmp QWORD [rdi], rdx
    jg .split
.noSplit:
    cmp rsi, 0
    mov rdi, [rdi+8]
    je .setHeadNoSplit
    mov QWORD [rsi+8], rdi
    jmp .afterSplit
.setHeadNoSplit:
    mov QWORD [pmmHead], rdi
    jmp .afterSplit
.split:
    mov rcx, rax
    push r8
    mov r8, [rdi]
    sub r8, rdx
    mov [rcx], r8
    pop r8
    mov rdi, [rdi+8]
    mov [rcx+8], rdi
    cmp rsi, 0
    mov rdi, [rdi+8]
    je .setHeadNoSplit
    mov QWORD [rsi+8], rcx
    jmp .afterSplit
.setHeadSplit:
    mov QWORD [pmmHead], rdi
.afterSplit:
    sub rax, [hhdmOffset]
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    ret
.nextIteration:
    mov rsi, rdi
    mov rdi, [rdi+8]
.condition:
    cmp rdi, 0
    jne .loop
    mov rdi, str0
    mov rsi, rdx
    shr rdx, 12
    call dbgPrintf
    call abort

section .rodata
str0: db "Failed to allocate 0x%llx bytes (0x%llx pages)", 0x0a, 0