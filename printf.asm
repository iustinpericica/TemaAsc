.data
    formatString: .asciz "%d %d acestea sunt numerele mele mele \n"
    x: .space 4
    formatScanFCitireUnNumar: .asciz "%d"
.text
.global main

main:
    push $x
    push $formatScanFCitireUnNumar
    call scanf
    pop %ebx
    pop %ebx

    push x
    push $2
    push $formatString
    call printf
    pop %ebx
    pop %ebx
    pop %ebx

et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
