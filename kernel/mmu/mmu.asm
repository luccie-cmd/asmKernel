global mmuInit
extern dbgPrintf
extern dbgPuts
extern abort
extern mmuInitVmm
extern mmuInitPaging
section .text
mmuInit:
    push rdi
    call mmuInitVmm
    mov rdi, str0
    call dbgPuts
    call mmuInitPaging
    mov rdi, str1
    call dbgPuts
    mov rdi, str2
    call dbgPuts
    pop rdi
    ret

section .rodata
str0: db "Initialized Virtual memory manager", 0x0a, 0
str1: db "Initialized Physical memory manager", 0x0a, 0
str2: db "TODO: Heap (Do we really need it though?)", 0x0a, 0