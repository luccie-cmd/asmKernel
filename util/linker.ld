/* Tell the linker that we want an x86_64 ELF64 output file */
OUTPUT_FORMAT(elf64-x86-64)
OUTPUT_ARCH(i386:x86-64)

/* We want the symbol _start to be our entry point */
ENTRY(KernelMain)

/* Define the program headers */
PHDRS
{
    text    PT_LOAD    FLAGS((1 << 0) | (1 << 2)) ; /* Execute + Read */
    rodata  PT_LOAD    FLAGS((1 << 2));             /* Read only */
    data    PT_LOAD    FLAGS((1 << 1) | (1 << 2)) ; /* Write + Read */
}

/* Adjusted Sections to place .bss and .data in RW PHDR and .init_array/.fini_array with .text */
SECTIONS
{
    /* Set the starting virtual address */
    . = 0xffffffff80000000;

    /* .text section, also includes .init_array and .fini_array */
    .text ALIGN(4K) :
    {
        __text_start = .;
        *(.text .text.*)
        *(.init_array .init_array.*) /* Place .init_array here */
        *(.fini_array .fini_array.*) /* Place .fini_array here */
        __text_end = .;
    } :text

    /* .rodata section */
    .rodata ALIGN(4K) :
    {
        __rodata_start = .;
        *(.rodata .rodata.*)
        __rodata_end = .;
    } :rodata

    /* .data section in RW segment */
    .data ALIGN(4K) :
    {
        __data_start = .;
        *(.data .data.*)
        KEEP(*(.gnu.linkonce.t.*)) /* Ensure vtable sections are kept */
        __data_end = .;
    } :data

    /* .bss section in RW segment */
    .bss ALIGN(4K) :
    {
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
    } :data

    /* Discard sections that are not required */
    /DISCARD/ : { *(.note.gnu.build-id) *(.eh_frame*) }
}
