global outb
global inw
section .text
outb:
    push rdx
    push rax
    mov dx, di
    mov al, sil
    out dx, al
    pop rax
    pop rdx
    ret

inw:
    push rdx
    mov dx, di
    in ax, dx
    pop rdx
    ret