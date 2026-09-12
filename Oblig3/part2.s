
.text
.global main

@ Function that `main` should call, leaf-funkjson
fib:
    @ Fill in the Fibonacci algorithm here
    @ Initialize the first two numbers in the sequence
    @ bytter 0->4, 1->5, 2->6 osv for å kun bruke calee-saved variabler

    MOV r1, #0  @ current
    MOV r2, #1  @ previous

    loop:
        CMP r0, #1
        BMI exit
        MOV r3, r1
        ADD r1, r2, r1
        MOV r2, r3
        SUB r0, r0, #1
        B loop
    exit:
        BX lr


main:
    push {lr}
    MOV r0, #13 @ N
    BL fib
    LDR r0, =output_string
    BL printf
    pop {lr}
    BX lr



@ The 'data' section contains static data for our program
.data
output_string:
    .asciz "%d\n"

