.data

    x: .long 5
    y: .long 5
    stringAfisareEgale: .asciz "Sunt egale \n"
    stringAfisareDiferite: .asciz "Sunt diferite \n"

.text
.global _start

_start:
    mov x, %eax
    mov y, %ebx
    cmp %eax, %ebx
    je _afisareEgale
    jmp _afisareDiferite


_afisareEgale:
    mov $4, %eax
    mov $1, %ebx
    mov $stringAfisareEgale, %ecx
    mov $13, %edx
    int $0x80
    jmp _etichetaExit

_afisareDiferite:
    mov $4, %eax
    mov $1, %ebx
    mov $stringAfisareDiferite, %ecx
    mov $16, %edx
    int $0x80
    jmp _etichetaExit

_etichetaExit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80

