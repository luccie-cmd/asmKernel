global pcieInit
extern getACPItableBySign
extern dbgPuts
extern dbgPrintf
extern usePciOld
extern abort
extern pcieSegmentBases
extern pcieSegmentCount
extern PCIreadConfigWord
extern PCIreadConfigByte
extern vmmMakeVirtual
section .text
pcieInit:
    push rdi
    push rsi
    push rcx
    mov rdi, str0
    call getACPItableBySign
    test rax, rax
    jz .noMcfg
    mov esi, [rax+4]
    sub rsi, 44
    shr rsi, 4
    cmp rsi, 1
    jl .invalidMcfg
    mov rdi, str2
    call dbgPrintf
    xor rcx, rcx
.loop:
    push r8
    push rsi
    push rdi
    push rdx
    push rcx
    push rax
    shl rcx, 4
    add rax, 44
    add rax, rcx
    xor rdx, rdx
    xor rcx, rcx
    xor r8, r8
    mov rsi, [rax]
    push rdi
    mov rdi, rsi
    call vmmMakeVirtual
    pop rdi
    mov rsi, rax
    mov dx, WORD [rax+8]
    mov cl, BYTE [rax+10]
    mov r8b, BYTE [rax+11]
    lea rdi, pcieSegmentBases
    shl rdx, 4
    add rdi, rdx
    mov QWORD [rdi], rsi
    mov BYTE [rdi+8], cl
    mov BYTE [rdi+9], r8b
    inc BYTE [pcieSegmentCount]
    pop rax
    pop rcx
    pop rdx
    pop rdi
    pop rsi
    pop r8
    inc rcx
.condition:
    cmp rcx, rsi
    jl .loop
    call initPCIe
    jmp .centralReturn
.noMcfg:
    mov BYTE [usePciOld], 1
    mov rdi, str1
    call dbgPuts
    call initPCIold
    jmp .centralReturn
.invalidMcfg:
    mov rdi, str3
    call dbgPuts
    call abort
.centralReturn:
    pop rcx
    pop rsi
    pop rdi
    ret

getVendorID:
    push r8
    mov r8, 0
    call PCIreadConfigWord
    pop r8
    ret

getDeviceID:
    push r8
    mov r8, 2
    call PCIreadConfigWord
    pop r8
    ret

; rdi, segment
; rsi, begin
; rdx, end
loopBus:
    push rdi
    push rsi
    push rdx
    push rcx
    mov rcx, rdx
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, str4
    call dbgPrintf
    xor r8, r8
.loopBus:
    push rcx
    xor r9, r9
    mov rcx, 32
.loopDevice:
    push rcx
    xor r10, r10
    mov rcx, 8
.loopFunc:
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    mov r8, r10
    push rdi
    push rsi
    push rdx
    push rcx
    mov rdi, rsi
    mov rsi, rdx
    mov rdx, rcx
    mov rcx, r10
    call getVendorID
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    cmp ax, 0xFFFF
    je .endLoopFunc
    mov r9, rax
    push rdi
    push rsi
    push rdx
    push rcx
    mov rdi, rsi
    mov rsi, rdx
    mov rdx, rcx
    mov rcx, r10
    call getDeviceID
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    push rax
    mov r13, rax
    mov rdi, str5
    call dbgPrintf
    add rsp, 8 ; Remove the stack variable
    mov r11, r8
    mov r12, r9
    mov r8, rsi
    mov r9, rdx
    mov r10, rcx
    push r8
    mov rdi, r8
    mov rsi, r9
    mov rdx, r10
    mov rcx, r11
    mov r8, 0x0A
    call PCIreadConfigByte
    mov r15, rax
    inc r8
    call PCIreadConfigByte
    mov r14, rax
    pop r8
    ; Do something
.endLoopFunc:
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    inc r10
.conditionFunc:
    cmp r10, rcx
    jl .loopFunc
    inc r9
.conditionDevice:
    pop rcx
    cmp r9, rcx
    jl .loopDevice
    inc r8
.conditionBus:
    pop rcx
    cmp r8, rcx
    jle .loopBus
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    ret

initPCIold:
    push rdi
    push rsi
    push rdx
    xor rdi, rdi
    xor rsi, rsi
    mov rdx, 0xFF
    call loopBus
    pop rdx
    pop rsi
    pop rdi
    ret

initPCIe:
    push rdi
    push rcx
    push rdx
    push r8
    xor rdi, rdi
    movzx rcx, BYTE [pcieSegmentCount]
.loop:
    lea rsi, pcieSegmentBases
    shl rdi, 4
    add rsi, rdi
    shr rdi, 4
    xor rdx, rdx
    mov BYTE dl,  [rsi+9]
    mov BYTE r8b, [rsi+8]
    xor rsi, rsi
    mov sil, r8b
    call loopBus
    inc rdi
.condition:
    cmp rdi, rcx
    jl .loop
    pop r8
    pop rdx
    pop rcx
    pop rdi
    ret

section .rodata
str0: db "MCFG"
str1: db "MCFG table was not found, PCI will be used instead", 0x0a, 0
str2: db "%llu MCFG entries present", 0x0a, 0
str3: db "Invalid MCFG detected", 0x0a, 0
str4: db "Initializing PCI/PCIe segment %04x (0x%02x-0x%02x)", 0x0a, 0 
str5: db "PCI: 0x%04.4u:%02.2u:%02.2u.%01.1u (0x%04.4x:0x%04.4x)", 0x0a, 0