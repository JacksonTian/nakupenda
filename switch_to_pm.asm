[bits 16]
; Switch to protected mode
switch_to_pm:

  cli ; We must switch of interrupts until we have
      ; set-up the protected mode interrupt vector
      ; otherwise interrupts will run riot.

  lgdt [gdt_descriptor]

  mov eax, cr0
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init_pm

[bits 32]
; init registers and the stack once in PM.
init_pm:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000
  mov esp, ebp

  call BEGIN_PM