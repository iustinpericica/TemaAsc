#printf proba
.data 

name2: .string "Your name is: %s "
formatScanf: .string "%s"
name: .string "What is your name?\n"
.bss
buffer: .space 100

.text 
.globl main 
main: 


    pushl $name       
    call printf 

   
    push $buffer 
    push $formatScanf 
    call scanf

    push $buffer
    push $name2
    call printf



et:
    lea buffer, %edi
    movl 3, %ecx
    movl $2, %ebx
    add %ecx, (%edi, %ebx, 4)
    
    push $buffer
    push $name2
    call printf


    pushl $0 
    call exit 