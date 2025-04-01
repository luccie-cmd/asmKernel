global mmuInitVmm
extern dbgPuts
extern abort
extern hhdmOffset
section .text
mmuInitVmm:
    push rdi
    mov rdi, [limine_hhdm_request.response]
    test rdi, rdi
    je .noResponse
    mov rdi, [rdi+8]
    mov [hhdmOffset], rdi
    pop rdi
    ret
.noResponse:
    mov rdi, str0
    call dbgPuts
    call abort

section .rodata
str0: db "Limine failed to set HHDM response", 0x0a, 0

section .limine_requests
align 16
%define LIMINE_COMMON_MAGIC 0xc7b1dd30df4c8b88, 0x0a82e883a194f07b
%define LIMINE_HHDM_REQUEST dq LIMINE_COMMON_MAGIC, 0x48dcf1cb8ad2b852, 0x63984e959a98244b
limine_hhdm_request:
    .id: LIMINE_HHDM_REQUEST
    .revision: dq 0
    .response: dq 0