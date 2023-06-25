.section .rodata
    msg_main_print_enter_numbers:
    .string "Enter a number : "

    msg_main_scan:
    .string "%d"

    msg_main_print_even:
    .string "Number is even\n"

    msg_main_print_odd:
    .string "Number is odd\n"

.section .text
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $4, %esp

    pushl   $msg_main_print_enter_numbers
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %ebx
    pushl   %ebx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    movl    -4(%ebp), %eax
    pushl   %eax
    call    check_even
    addl    $4, %esp

    cmpl    $1, %eax
    jne     label_else
    pushl   $msg_main_print_even
    call    printf
    addl    $4, %esp
    jmp     label_exit

label_else:
    pushl   $msg_main_print_odd
    call    printf
    addl    $4, %esp

label_exit:
    pushl   $0
    call    exit


.globl  check_even
.type   check_even, @function
check_even:
    pushl   %ebp
    movl    %esp, %ebp

    movl    8(%ebp), %eax

    andl    $1, %eax
    cmpl    $0, %eax
    jne     label_false
    movl    $1, %eax
    jmp     label_return

label_false:
    movl    $0, %eax

label_return:
    movl    %ebp, %esp
    popl    %ebp
    ret

