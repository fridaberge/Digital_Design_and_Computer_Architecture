
.text
.global main

@ Main function of program
main:
    @ First load the desired Fibonacci number
    MOV r0, #13 @ N
    @ Initialize the first two numbers in the sequence
    MOV r1, #0  @ current
    MOV r2, #1  @ previous

@ Loop will do the main work calculating the Fibonacci sequence
loop:
    CMP r0, #1
    BMI exit
    MOV r3, r1
    ADD r1, r2, r1
    MOV r2, r3
    SUB r0, r0, #1

    @ Jump to start of loop
    B loop


@ To be a good citizen we branch (and exchange) on the lr register
@ to return to the caller
exit:
    BX lr
