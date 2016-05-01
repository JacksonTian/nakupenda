; prints the value of DX as hex
print_hex:
  pusha

  mov al, dh
  shr al, 4
  call hex_digit_to_ascii
  mov [HEX_OUT+2], al

  mov al, dh
  and al, 0x0f
  call hex_digit_to_ascii
  mov [HEX_OUT+3], al

  mov al, dl
  shr al, 4
  call hex_digit_to_ascii
  mov [HEX_OUT+4], al

  mov al, dl
  and al, 0x0f
  call hex_digit_to_ascii
  mov [HEX_OUT+5], al

  mov bx, HEX_OUT       ; print the string poijnted to
  call print_string     ; by BX
  popa
  ret

; Converts a digit in range 0..15 to an ASCII representation of 0..9a..f,
; passed in AL, returned in AL
hex_digit_to_ascii:
  cmp al, 9
  jle digit_char
  add al, 39

digit_char:
  add al, 48
  ret

; global variables
HEX_OUT: db '0x0000', 0
