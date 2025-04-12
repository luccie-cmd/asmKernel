global halIdtInit
global registerHandler
global enableGate
extern isrInitGates
extern dbgPrintf
extern abort
section .text
halIdtInit:
    push rdi
    push rsi
    mov WORD [IDT.limit], 4095
    mov QWORD [IDT.base], entries
    mov rdi, IDT
    lidt [rdi]
    call isrInitGates
    xor rdi, rdi
    mov rsi, 255
    jmp .condition
.loop:
    call enableGate
    inc rdi
.condition:
    cmp rdi, rsi
    jle .loop
    sti
    pop rsi
    pop rdi
    ret

; Masks and bit positions for IDTEntry structure fields
%define IDT_OFFSET0_MASK      0xFFFF              ; Mask for offset0 (16 bits)
%define IDT_SEGMENT_SEL_MASK  0xFFFF              ; Mask for segment selector (16 bits)
%define IDT_IST_MASK          0b00000111          ; Mask for IST (3 bits)
%define IDT_RESERVED0_MASK    0b11111000          ; Mask for Reserved0 (5 bits)
%define IDT_GATE_TYPE_MASK    0b00001111          ; Mask for Gate type (4 bits)
%define IDT_ZERO_MASK         0b00010000          ; Mask for Zero bit (1 bit)
%define IDT_DPL_MASK          0b01100000          ; Mask for DPL (2 bits)
%define IDT_PRESENT_MASK      0b10000000          ; Mask for Present flag (1 bit)
%define IDT_OFFSET1_MASK      0xFFFF              ; Mask for offset1 (16 bits)
%define IDT_OFFSET2_MASK      0xFFFFFFFF          ; Mask for offset2 (32 bits)
%define IDT_RESERVED1_MASK    0xFFFFFFFF          ; Mask for Reserved1 (32 bits)

; Bit positions for shifting fields
%define IDT_IST_SHIFT         0                   ; IST starts at bit 0 of byte 4
%define IDT_RESERVED0_SHIFT   3                   ; Reserved0 starts at bit 3 of byte 4
%define IDT_GATE_TYPE_SHIFT   0                   ; Gate type starts at bit 0 of byte 5
%define IDT_ZERO_SHIFT        4                   ; Zero starts at bit 4 of byte 5
%define IDT_DPL_SHIFT         5                   ; DPL starts at bit 5 of byte 5
%define IDT_PRESENT_SHIFT     7                   ; Present starts at bit 7 of byte 5

registerHandler:
    push rdi
    push rsi
    lea r8, entries
    shl rdi, 4
    add r8, rdi
    shr rdi, 4
    mov [r8], si
    mov WORD [r8+2], 0x8
    mov BYTE [r8+4], 0
    movzx rdi, BYTE [r8+5]
    shl rdx, IDT_GATE_TYPE_SHIFT
    or rdi, rdx
    mov [r8+5], dil
    push rsi
    shr rsi, 16
    mov [r8+6], si
    pop rsi
    shr rsi, 32
    mov [r8+8], esi
    pop rsi
    pop rdi
    ret

enableGate:
    push rsi
    push rdi
    lea rsi, entries
    sal rdi, 4
    add rsi, rdi
    or BYTE [rsi+5], IDT_PRESENT_MASK
    pop rdi
    pop rsi
    ret

section .bss
entries: resb 4096

section .data
IDT:
    .limit: dw 0
    .base:  dq 0