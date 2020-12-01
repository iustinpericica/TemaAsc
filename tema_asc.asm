.data
    // format citiri:
    formatCitireUnIntreg: .asciz "%d"
    formatCitireDoiIntregi: .asciz "%d %d"

    formatCerinta1SwitchMalitios: .asciz "switch malitios index %d:"
    formatCerinta1Host: .asciz " host index %d;"

    formatCerinta1Switch: .asciz " switch index %d;"

    formatCerinta1SwitchMalitios1: .asciz " switch malitios index %d;"

    formatCerinta1SwitchController: .asciz " controller index %d;"
    
    formatAfisareCuSpatiuUnIntreg: .asciz "%d \n"
    spatiu: .asciz "\n"

    
    
    matrix: .space 1600
    roles: .space 80
    role: .space 4
    n: .space 4
    cerinta: .space 4
    nrLegaturi: .space 4
    i: .space 4
    j: .space 4

    legatura1: .space 4
    legatura2: .space 4

.text

.global main

main:
    lea matrix, %edi

    //citire n, nrLegaturi --- INCEPERE ----
    
    pushl $nrLegaturi
    push $n
    push $formatCitireDoiIntregi
    call scanf
    pop %ebx
    popl %ebx
    popl %ebx

    //citire n --- TERMINARE ----

citire_legaturi:
    movl $0, i

    et_baby_for:
        
        mov nrLegaturi, %ecx
        cmpl %ecx, i
        je et_citire_roles
        incl i

        // citire legaturi 2 cate 2, --- INCEPERE ---
        pushl $legatura1
        pushl $legatura2
        push $formatCitireDoiIntregi
        call scanf
        pop %ebx
        popl %ebx
        popl %ebx
        // citire legaturi 2 cate 2, --- TERMINARE ---

        // INCEPERE punem in matrice 1 in matrix[legatura1][legatura2] = matrix[legatura2][legatura1] = 1;
        lea matrix, %edi

        movl n, %eax
        mull legatura1
        add  legatura2,%eax

        mov $1, %edx
        movl %edx, (%edi, %eax, 4)

        movl n, %eax
        mull legatura2
        add  legatura1,%eax

        mov $1, %edx
        movl %edx, (%edi, %eax, 4)
        // TERMINARE punem in matrice 1 in matrix[legatura1][legatura2] = matrix[legatura2][legatura1] = 1;


        jmp et_baby_for
        



et_citire_roles:
    movl $0, i

    et_baby_for_1:
        mov n, %ecx
        cmpl %ecx, i
        je et_citire_cerinta

        pushl $role
        push $formatCitireUnIntreg
        call scanf
        pop %ebx
        popl %ebx

        lea roles, %edi
        movl role, %eax
        movl i, %ebx
        movl %eax, (%edi, %ebx, 4)

        incl i
        jmp et_baby_for_1

et_citire_cerinta:


    push $cerinta
    push $formatCitireUnIntreg
    call scanf
    pop %ebx
    popl %ebx

    cmpl $1, cerinta
    je cerinta_1

cerinta_1:
    
    movl $0, i
    et_for_2:

        movl n, %eax
        cmpl i, %eax
        je et_exit

        // if roles[i] == 3
        lea roles, %edi
        movl i, %ebx
        movl (%edi, %ebx, 4), %eax
        cmpl $3, %eax
        je roles_i_egal_3
        incl i
        jmp et_for_2

        roles_i_egal_3:
            //cout<<""switch malition index i :
            push $spatiu
            call printf
            pop %ebx

            pushl i
            push $formatCerinta1SwitchMalitios
            call printf
            pop %ebx
            popl %ebx

            push $0
            call fflush
            pop %ebx

            // i = switch malitios

            // for(int j = 0;j<n;++j)

            movl $0, j

            et_for_j_1:
                movl j, %eax
                cmp %eax, n
                je terminare_for_main

                lea matrix, %edi

                movl n, %eax
                mull i
                add  j,%eax

                //(%edi, %eax, 4)

                cmpl $1, (%edi, %eax, 4)
                je et_switch3Cases
                //else:
                incl j
                jmp et_for_j_1
                // mergem iar in for

                et_switch3Cases:
                    // cele 3 cazuri
                    // afisez mai intai conexiunile:

                    // if role[j] == 1 <==> HOST

                    lea roles, %edi
                    movl j, %eax
                    cmpl $1, (%edi, %eax, 4)
                    je afisare_host

                    movl j, %eax
                    cmpl $2, (%edi, %eax, 4)
                    je afisare_switch


                    movl j, %eax
                    cmpl $3, (%edi, %eax, 4)
                    je afisare_switch_malitios

                    movl j, %eax
                    cmpl $4, (%edi, %eax, 4)
                    je afisare_controller

                    afisare_host:

                        pushl j
                        push $formatCerinta1Host
                        call printf
                        pop %ebx
                        popl %ebx

                        push $0
                        call fflush
                        pop %ebx

                        incl j
                        jmp et_for_j_1

                    afisare_switch:
                        pushl j
                        push $formatCerinta1Switch
                        call printf
                        pop %ebx
                        popl %ebx

                        push $0
                        call fflush
                        pop %ebx

                        incl j
                        jmp et_for_j_1

                    afisare_switch_malitios:
                        pushl j
                        push $formatCerinta1SwitchMalitios1
                        call printf
                        pop %ebx
                        popl %ebx

                        push $0
                        call fflush
                        pop %ebx

                        incl j
                        jmp et_for_j_1

                    afisare_controller:
                        pushl j
                        push $formatCerinta1SwitchController
                        call printf
                        pop %ebx
                        popl %ebx

                        push $0
                        call fflush
                        pop %ebx

                        incl j
                        jmp et_for_j_1

            terminare_for_main:
                incl i
                jmp et_for_2



et_exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80



