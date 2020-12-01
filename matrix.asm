.data
    columns: .long 4
    lines: .long 3
    matrix: .space 1600
    lineIndex: .long 3
    columnIndex: .space 4
    formatAfisare: .asciz "%d \n"
    formatAfisareCuSpatiuDoiIntregi: .asciz "(%d, %d) "
    formatAfisareCuLinieNouaDoiIntregi: .asciz "%d %d \n"
    formatAfisareCuSpatiuUnIntreg: .asciz "%d "
    formatCitireUnNumar: .asciz "%d"
    spatiu: .asciz "\n"
    i: .space 4
    j: .space 4
    doi: .long 2
    suma: .long 0
    elCurent: .space 4
    x: .space 4

.text
.global main

main:
    lea matrix, %edi
    movl $-1, i
    movl $0, j

    push $lines
    push $formatCitireUnNumar
    //call scanf
    pop %ebx
    popl %ebx
    movl lines, %ebx
    movl %ebx, columns

    // lines = columns = nr citit de la tastatura

citire_et_main_for_i:
    

    incl i
    movl lines, %eax
    cmp %eax, i
    je eticheta
    // verific i < n, daca i == n => et_exit

    movl $0, j
    citire_et_for_j:
        movl columns, %eax
        cmp j, %eax
        je citire_et_main_for_i
        // verific j < m, daca j == m => continue; <==> et_main_for_i

        push $x
        push $formatCitireUnNumar
        call scanf
        pop %ebx
        popl %ebx

        movl columns, %eax
        mull i
        add  j,%eax

        mov x, %edx
        movl %edx, (%edi, %eax, 4)

        incl j
        jmp citire_et_for_j
        // j++, continue;

eticheta:
    movl $-1, i
    movl $0, j

et_main_for_i:
    push $spatiu
    call printf
    pop %ebx

    incl i
    movl lines, %eax
    cmp %eax, i
    je et_exit
    // verific i < n, daca i == n => et_exit

    movl $0, j
    et_for_j:
        movl columns, %eax
        cmp j, %eax
        je et_main_for_i
        // verific j < m, daca j == m => continue; <==> et_main_for_i

        movl columns, %eax
        mull i
        add  j,%eax
        pushl (%edi, %eax, 4)
        push $formatAfisareCuSpatiuUnIntreg
        call printf
        pop %ebx
        popl %ebx     
        // am afisat elementul matrix[i][j]


        incl j
        jmp et_for_j
        // j++, continue;

        

et_exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
