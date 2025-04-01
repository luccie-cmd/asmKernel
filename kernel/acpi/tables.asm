global getACPItableBySign
extern ACPInumEntries
extern xsdtAddr
extern dbgPrintf
section .text
getACPItableBySign:
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    mov rdx, [ACPInumEntries]
    mov rbx, [xsdtAddr]
    add rbx, 36
.loop:
    push rdx
    push rcx
    push rbx
    push rdi
    shl rcx, 3
    add rbx, rcx
    mov rdx, [rbx]
    mov rbx, [rdx]
    mov rdi, [rdi]
    cmp ebx, edi
    cmove rax, rdx
    pop rdi
    pop rbx
    pop rcx
    pop rdx
    je .return
.end:
    inc rcx
    cmp rcx, rdx
    jl .loop
    mov rsi, rdi
    mov rdi, str0
    call dbgPrintf
    xor rax, rax
.return:
    pop rdx
    pop rcx
    pop rbx
    ret

section .rodata
str0: db "Table %.4s not found", 0x0a, 0