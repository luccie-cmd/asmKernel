global acpiInit
extern dbgPuts
extern abort
extern vmmMakeVirtual
extern getACPItableBySign
extern ACPInumEntries
extern xsdtAddr
extern outb
extern inw
extern dbgPrintf
section .text
initFADT:
    mov rdi, str2
    call getACPItableBySign
    cmp DWORD [rax+0x30], 0
    je .cmdPort0
    movzx rdi, BYTE [rax+52]
    cmp dil, [rax+53]
    jz .enableDisable
    mov edi, DWORD [rax+64]
    and rdi, 1
    jnz .pm1aCrtl
    mov rdi, str6
    push rax
    call dbgPuts
    pop rax
    mov rdi, [rax+48]
    mov rsi, [rax+52]
    call outb
.loop:
    mov rdi, [rax+64]
    push rax
    call inw
    and rax, 1
    pop rax
    jz .loop
    mov rdi, str1
    call dbgPuts
    je .end
.cmdPort0:
    mov rdi, str3
    call dbgPuts
    jmp .end
.enableDisable:
    mov rdi, str4
    call dbgPuts
    jmp .end
.pm1aCrtl:
    mov rdi, str5
    call dbgPuts
.end:
    ret

acpiInit:
    push rdi
    push rsi
    mov rdi, [limine_rsdp_request.response]
    cmp rdi, 0
    je .noResponse
    mov rdi, [rdi+8]
    mov rdi, [rdi+0x18]
    call vmmMakeVirtual
    mov rdi, rax
    mov QWORD [xsdtAddr], rdi
    movsx rsi, DWORD [rdi+0x04]
    sub rsi, 36
    shr rsi, 3
    mov [ACPInumEntries], rsi
    call initFADT
    pop rsi
    pop rdi
    ret
.noResponse:
    mov rdi, str0
    call dbgPuts
    call abort

section .rodata
str0: db "Limine failed to set RSDP response", 0x0a, 0
str1: db "Enabled ACPI mode", 0x0a, 0
str2: db "FACP"
str3: db "ACPI mode already enabled. SMI command port == 0", 0x0a, 0
str4: db "ACPI mode already enabled. table->AcpiEnable == table->AcpiDisable == 0", 0x0a, 0
str5: db "ACPI mode already enabled. (table->PM1aControlBlock & 1) == 1", 0x0a, 0
str6: db "Enabling ACPI mode", 0x0a, 0

section .limine_requests
align 16
%define LIMINE_COMMON_MAGIC 0xc7b1dd30df4c8b88, 0x0a82e883a194f07b
%define LIMINE_RSDP_REQUEST dq LIMINE_COMMON_MAGIC, 0xc5e77b6b397e7b43, 0x27637845accdcf3c
limine_rsdp_request:
    .id: LIMINE_RSDP_REQUEST
    .revision: dq 0
    .response: dq 0