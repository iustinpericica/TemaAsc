.data
    x: .long 15
    y: .long 20
    str: .asciz "Hello\n"
    sum: .space 4
    inmultire: .space 4
.text
.globl _start

_start:
    mov x, %eax
    mov y, %ebx
    mul %ebx
    mov %eax, inmultire

    mov x, %eax
    mov $4, %ebx
    div %ebx


_exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80

