
  mov ah, 0x0e

  mov bp, 0x8000
  mov sp, bp

  ; from high to low
  push 'A'  ; 2 bytes
  push 'B'  ; 2 bytes
  push 'C'  ; 2 bytes
  ; 0x8000 = 'A'
  ; 0x7fff = 'B'
  ; 0x7ffe = 'C'

  pop bx    ; pop to bx
  mov al, bl  ; get the low of bx(bl)
  int 0x10

  pop bx
  mov al, bl
  int 0x10

  mov al, [0x7ffe]
  int 0x10


  jmp $

  times 510-($-$$) db 0
  dw 0xaa55
