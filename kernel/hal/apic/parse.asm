global parseMadt
extern getACPItableBySign
extern dbgPrintf
section .text
parseMadt:
    mov rdi, str0
    call getACPItableBySign
    mov rdi, rax
    mov r8d, DWORD [rdi+4]
    sub r8, 44
    add rdi, 44
    xor rcx, rcx
    jmp .condition
.loop:
    mov r15, rdi
    push rdi
    movsx rsi, BYTE [r15]
    
    xor r9, r9
    movzx r9, BYTE [r15+1]
    add rcx, r9
    pop rdi
    add rdi, r9
.condition:
    cmp rcx, r8
    jl .loop
    ret

section .rodata
str0: db "APIC"
str1: db "MADT entry with type 0x%hhx", 0x0a, 0