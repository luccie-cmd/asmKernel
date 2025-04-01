global halGdtInit
section .text
halGdtInit:
    lea rax, [GDTR]
    lgdt [rax]
    push 0x08
    lea rax, [.reload_CS]
    push rax
    retfq
.reload_CS:
    mov rax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov rax, 0x28
    ltr ax
    ret

section .data
global GDT
GDT:
    dq 0x0000000000000000 ; Null descriptor
    dq 0x00AF9A000000FFFF ; Kernel CODE (64-bit)
    dq 0x00AF92000000FFFF ; Kernel DATA (64-bit)
    dq 0x00AFFA000000FFFF ; User CODE (64-bit)
    dq 0x00AFF2000000FFFF ; User DATA (64-bit)
    dq 0                  ; TSS Low
    dq 0                  ; TSS High
GDTR:
    dw GDT_end - GDT - 1
    dq GDT
GDT_end: