.data
    v: .long 3, 4, 5, 6
    n: .long 3
.text
.globl _start

_start:
    mov n, %ecx
    mov $0, %ebx
    lea v, %edi

et_for:
    add (%edi,%ecx,4), %ebx
    loop et_for
    
et_exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
