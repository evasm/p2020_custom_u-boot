OUTPUT_ARCH(powerpc)
ENTRY(_start_e500)
PHDRS
{
  text PT_LOAD;
  bss PT_LOAD;
}
SECTIONS
{
  . = + SIZEOF_HEADERS;
  .interp : { *(.interp) }
  .text :
  {
    *(.text*)
   } :text
    _etext = .;
    PROVIDE (etext = .);
    .rodata :
   {
    *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
  } :text
  . = (. + 0x00FF) & 0xFFFFFF00;
  _erotext = .;
  PROVIDE (erotext = .);
  .reloc :
  {
    _GOT2_TABLE_ = .;
    KEEP(*(.got2))
    KEEP(*(.got))
    _FIXUP_TABLE_ = .;
    KEEP(*(.fixup))
  }
  __got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
  __fixup_entries = (. - _FIXUP_TABLE_) >> 2;
  .data :
  {
    *(.data*)
    *(.sdata*)
  }
  _edata = .;
  PROVIDE (edata = .);
  . = .;
  . = ALIGN(4);
  .u_boot_list : {
 KEEP(*(SORT(.u_boot_list*)));
  }
  . = .;
  __start___ex_table = .;
  __ex_table : { *(__ex_table) }
  __stop___ex_table = .;
  . = ALIGN(256);
  __init_begin = .;
  .text.init : { *(.text.init) }
  .data.init : { *(.data.init) }
  . = ALIGN(256);
  __init_end = .;
  .bootpg 0xeffffffc - 0xffc :
  {
    arch/powerpc/cpu/mpc85xx/start.o (.bootpg)
  } :text = 0xffff
  .resetvec 0xeffffffc :
  {
    KEEP(*(.resetvec))
  } :text = 0xffff
  . = 0xeffffffc + 0x4;
  __bss_start = .;
  .bss (NOLOAD) :
  {
   *(.sbss*)
   *(.bss*)
   *(COMMON)
  } :bss
  . = ALIGN(4);
  __bss_end = . ;
  PROVIDE (end = .);
}
