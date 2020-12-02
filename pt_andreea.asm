.data
    G: .space 1600
	//20*20*4
	n: .space 4
	lineIndex: .space 4
	columnIndex: .space 4
	i: .space 4
	//left
	j: .space 4
	//right
        roles: .space 80
 	//20*4
	nrLeg: .space 4
        index: .space 4
	citire: .asciz "%d"
	scriere: .asciz "%d "
	// scriere temporara <=> pt verificarea matricei etc 
        fo: .asciz "switch malitios index"
	//first output; L=23
        o1: .asciz "host index "
	//L=12
        o2: .asciz "switch index "
	//L=14
        o3: .asciz "switch malitios index "
	//L=25
        o4: .asciz "controller index "
	//L=18
        lo: .asciz ";"
	//last output; L=2
        io1: .asciz ": "
	//L=3
        io2: .asciz "; "
	//L=3
        nl: .asciz "\n"
	//L=2
        vecin: .space 4
        val: .space 4

.text

.global main

main:
	pushl $n
	pushl $citire
	call scanf
	pop %ebx
	pop %ebx

	pushl $nrLeg
	pushl $citire
	call scanf
	popl %ebx
	popl %ebx

// for (int index = 0; index < nrLeg; index++)
// {
//      scanf("%d", &i);
//      scanf("%d", &j);
//      G[i][j] = G[j][i] = 1;
// }
    movl $0, index
declar_G:
    movl index, %ecx
    cmp %ecx, nrLeg
    je afisez_G

    pushl $i
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx

    pushl $j
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx


    movl i, %eax
    movl $0, %edx
    mull n
    addl j, %eax
    lea G, %edi
    movl $1, (%edi, %eax, 4)

    movl j, %eax
    movl $0, %edx
    mull n
    addl i, %eax
    lea G, %edi
    movl $1, (%edi, %eax, 4)


    incl index
    jmp declar_G
// am terminat treaba cu i si j <=> pot sa ii folosesc in alta parte acum

afisez_G:
    movl $0, lineIndex
    for_lines:
        movl lineIndex, %ecx
        cmp %ecx, n
        je et_exit

        movl $0, columnIndex
        for_columns:
            movl columnIndex, %ecx
            cmp %ecx, n
            je cont

            // afisez matrix[lineIndex][columnIndex]
            // lineIndex * n + columnIndex
            movl lineIndex, %eax
            movl $0, %edx
            mull n
            addl columnIndex, %eax
            // %eax = lineIndex * n + columnIndex

            lea G, %edi
            movl (%edi, %eax, 4), %ebx

            pushl %ebx
            pushl $scriere
            call printf
            popl %ebx
            popl %ebx

            pushl $0
            call fflush
            popl %ebx

            incl columnIndex
            jmp for_columns

    cont:
        movl $4, %eax
        movl $1, %ebx
        movl $nl, %ecx
        movl $2, %edx
        int $0x80

        incl lineIndex
        jmp for_lines

movl $0, index
citire_roles:
	movl index, %ecx
	cmp %ecx, n
	je afisare_roles

	pushl $val
	pushl $citire
	call scanf
	popl %ebx
	popl %ebx

	lea roles, %edi
	movl $val, (%edi, %ecx, 4)

	incl index
	jmp citire_roles

	movl $0, index
afisare_roles:
		movl index, %ecx
		cmp %ecx, n
		je et_exit

		lea roles, %edi
		movl (%edi, %ecx, 4), %eax

		pushl %eax
		pushl $scriere
		call printf
		popl %ebx
		popl %ebx

		pushl $0
		call fflush
		popl %ebx

		incl index
		jmp afisare_roles
		int $0x80
et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
    