global mmuInitPaging
extern dbgPrintf
extern abort
extern dbgPuts
extern vmmMakeVirtual
extern pmmHead
%include "kernel/mmu/pmm.inc"
section .text
mmuInitPaging:
    push rdi
    push rsi
    push rcx
    push rdx
    mov rdi, [limine_memmap_request.response]
    test rdi, rdi
    je .noResponse
    mov rsi, [rdi+16]
    mov rdi, [rdi+8]
    xor rdx, rdx
.loop1:
    push rdi
    push rsi
    push rdx
    shl rdx, 3
    mov rdi, [rsi+rdx]
    mov rsi, [rdi+8]
    mov rdx, [rdi+16]
    mov rdi, [rdi]
    test rdx, rdx
    je .append
    cmp rdx, 5
    je .append
    jmp .next
.append:
    cmp rsi, PAGE_SIZE
    jl .next
    call vmmMakeVirtual
    mov [rax], rsi
    mov rsi, [pmmHead]
    test rsi, rsi
    jz .setHead
    mov [rax+8], rsi
.setHead:
    mov [pmmHead], rax
.next:
    pop rdx
    pop rsi
    pop rdi
    inc rdx
.condition1:
    cmp rdx, rdi
    jl .loop1
    pop rdx
    pop rcx
    pop rsi
    pop rdi
    ret
.noResponse:
    mov rdi, str0
    call dbgPuts
    call abort

section .rodata
str0: db "Limine failed to set memory map response", 0x0a, 0

section .limine_requests
align 16
%define LIMINE_COMMON_MAGIC 0xc7b1dd30df4c8b88, 0x0a82e883a194f07b
%define LIMINE_MEMMAP_REQUEST dq LIMINE_COMMON_MAGIC, 0x67cf3d9d378a806f, 0xe304acdfc50c3c62
limine_memmap_request:
    .id: LIMINE_MEMMAP_REQUEST
    .revision: dq 0
    .response: dq 0