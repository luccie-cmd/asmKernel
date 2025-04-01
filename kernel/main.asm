global KernelMain
extern abort
extern halEarlyInit
extern mmuInit
extern acpiInit
extern pcieInit
extern dbgPuts
section .text
KernelMain:
    call halEarlyInit
    mov rdi, str0
    call dbgPuts
    call mmuInit
    mov rdi, str1
    call dbgPuts
    call acpiInit
    mov rdi, str2
    call dbgPuts
    call pcieInit
    mov rdi, str3
    call dbgPuts
    mov rdi, str4
    call dbgPuts
    call abort

section .rodata
str0: db "Initialized early HAL", 0x0a, 0
str1: db "Initialized memory managers", 0x0a, 0
str2: db "Initialized ACPI subsystem", 0x0a, 0
str3: db "Initialized PCIe", 0x0a, 0
str4: db "TODO: PCIE, APIC, IOAPIC, IRQS, DRIVERS, HPET, SYSCALL, VFS, SCHED", 0x0a, 0