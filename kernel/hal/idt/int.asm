global handleInt
global initJumpTable
extern abort
extern dbgPrintf
extern handleDB
extern handleBP
section .text
initJumpTable:
    push rdi
    push rsi
    mov rdi, 1
    mov rsi, handleDB
    call setJumpTableEntry
    mov rdi, 3
    mov rsi, handleBP
    call setJumpTableEntry
    pop rdi
    pop rsi
    ret

printFlags:
    ret

printRegs:
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r15
    mov r15, rdi
    mov rdi, str1
    mov rsi, [r15+0xA8]
    mov rdx, [r15+0xB0]
    call dbgPrintf
    mov rdi, str2
    mov rsi, [r15+0xA0]
    mov rdx, [r15+0x98]
    mov rcx, [r15+0x90]
    mov r8,  [r15+0x88]
    call dbgPrintf
    mov rdi, str3
    mov rsi, [r15+0x70]
    mov rdx, [r15+0x68]
    mov rcx, [r15+0x78]
    mov r8,  [r15+0x80]
    call dbgPrintf
    mov rdi, str4
    mov rsi, [r15+0x60]
    mov rdx, [r15+0x58]
    mov rcx, [r15+0x50]
    mov r8,  [r15+0x48]
    call dbgPrintf
    mov rdi, str5
    mov rsi, [r15+0x40]
    mov rdx, [r15+0x38]
    mov rcx, [r15+0x30]
    mov r8,  [r15+0x28]
    call dbgPrintf
    mov rdi, str6
    mov rsi, [r15+0xB8]
    call dbgPrintf
    call printFlags
    pop r15
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    ret

handleInt:
    call printRegs
    lea rsi, intJumpTable
    mov rax, [rdi+0xA8]
    shl rax, 3
    add rsi, rax
    cmp QWORD [rsi], 0
    je unhandledInterrupt
    jmp QWORD [rsi]

unhandledInterrupt:
    mov rsi, [rdi+0xA8]
    mov rdi, str0
    call dbgPrintf
    call abort

setJumpTableEntry:
    push rax
    push rdi
    push rsi
    lea rax, intJumpTable
    shl rdi, 3
    add rax, rdi
    mov [rax], rsi
    pop rsi
    pop rdi
    pop rax
    ret

section .bss
intJumpTable:
    resq 256

section .rodata
str0: db "TODO: handle interrupt 0x%lx", 0x0a, 0
str1: db 0x09, "v=0x%016.16llx e=0x%016.16llx", 0x0a, 0
str2: db "RAX=0x%016.16llx RBX=0x%016.16llx RCX=0x%016.16llx RDX=0x%016.16llx", 0x0a, 0
str3: db "RSI=0x%016.16llx RDI=0x%016.16llx RBP=0x%016.16llx RSP=0x%016.16llx", 0x0a, 0
str4: db "R8 =0x%016.16llx R9 =0x%016.16llx R10=0x%016.16llx R11=0x%016.16llx", 0x0a, 0
str5: db "R12=0x%016.16llx R13=0x%016.16llx R14=0x%016.16llx R15=0x%016.16llx", 0x0a, 0
str6: db "RIP=0x%016.16llx RFL=", 0