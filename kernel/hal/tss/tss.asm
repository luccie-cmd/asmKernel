global halTssInit
extern GDT
extern abort
section .text
halTssInit:
    push rdi
    push rsi
    lea rax, [tssEntry]
    mov rdi, TSS_END
    mov rsi, TSS
    sub rdi, rsi
    dec rdi
    mov [rax+0], di
    mov [rax+2], si
    shr rsi, 16
    mov [rax+4], sil
    mov BYTE [rax+5], 0x89
    mov BYTE [rax+6], 0
    shr rsi, 8
    mov [rax+7], si
    shr rsi, 8
    mov [rax+8], esi
    mov DWORD [rax+12], 0
    mov rax, [tssEntry]
    mov [GDT+0x28], rax
    mov rax, [tssEntry+8]
    mov [GDT+0x30], rax
    pop rsi
    pop rdi
    ret

section .data
global TSS
TSS:
    .reserved1: dd 0
    .rsp0:      dq 0
    .rsp1:      dq 0
    .rsp2:      dq 0
    .reserved2: dq 0
    .ist1:      dq 0
    .ist2:      dq 0
    .ist3:      dq 0
    .ist4:      dq 0
    .ist5:      dq 0
    .ist6:      dq 0
    .ist7:      dq 0
    .reserved3: dq 0
    .reserved4: dw 0
    .iopb:      dw 104
TSS_END:
tssEntry: times 2 dq 0