extern halTssInit
extern halGdtInit
extern halIdtInit
extern halExtInit
extern initJumpTable
global halEarlyInit
section .text
halEarlyInit:
    call halExtInit
    call halIdtInit
    call halTssInit
    call halGdtInit
    call initJumpTable
    ret