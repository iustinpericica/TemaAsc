.data
    x: .space 4
    citire: .asciz "%d"
    poz: .asciz "pozitiv"
    neg: .asciz "negativ"
    zero: .asciz "zero"
.text
.global main
main:
    push $x
    push $citire
    call scanf
    pop %ebx
    pop %ebx
    
    movl x, %eax
    movl $0, %ebx
    cmp %ebx, %eax
    jg af_poz
    je af_zero
    jl af_neg
    jmp et_exit

af_poz:
    mov $4, %eax
    mov $1, %ebx
    mov $poz, %ecx
    mov $8, %edx
    int $0x80
    jmp et_exit
af_zero:
    mov $4, %eax
    mov $1, %ebx
    mov $zero, %ecx
    mov $5, %edx
    int $0x80
    jmp et_exit
af_neg:
    mov $4, %eax
    mov $1, %ebx
    mov $neg, %ecx
    mov $8, %edx
    int $0x80
    jmp et_exit
et_exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80

