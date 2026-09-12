
@ The two numbers we want to add
num1:   .word   0x40600000
num2:   .word   0x40400000

.text
.global main
main:
    @ Load numbers
    @ 0 01111111 00000000000000000000000
    LDR r0, num1
    LDR r1, num2

    @ 1:
    @ Maskere ut og flytte ned eksponenten i begge tall, slik at eksponenten ligger i de minst signifikante bit'ene i registeret.
    @ eksponent: 1 00000000 11111111111111111111111
    LDR r10, =0x807FFFFF
    BIC r2, r0, r10
    BIC r3, r1, r10
    @ r2 og r3: 0 01111111 000000000000000000000
    @ flytte ned eksponent til minst signifikante bits
    LSR r2, r2, #23
    LSR r3, r3, #23
    @ r2 og r3: 0 00000000 000000000000001111111

    @ 2
    @ Maskere ut desimalen, og legge til et ledende 1 tall.
    @ desimal: 1 11111111 00000000000000000000000
    LDR r10, =#0xFF800000
    BIC r4, r0, r10
    BIC r5, r1, r10
    @ r4 og r5: 0 00000000 000000000000000000000
    @ ledende 1: 0 00000001 000000000000000000000
    LDR r10, =#0x800000
    ORR r4, r4, r10
    ORR r5, r5, r10
    @ r4 og r5: 0 00000001 000000000000000000000

    @ 3 og 4
    @ Trekke den minste eksponenten fra den største og sette eksponenten til det nye tallet lik den største av de to eksponentene.
    @ Høyre skifte desimalen til det minste tallet med forskjellen av eksponentene fra steget over.
    CMP r2, r3
    @ r2 er størst
    BNE hopp
        SUB r6, r3, r2
        MOV r9, r3
        @ legge r3 i r9 som er sluttekponenten fordi r3 er større enn r2
        LSR r4, r4, r6
    hopp: 
        SUB r6, r2, r3
        MOV r9, r2
        @ legge r2 inn i r9 som er slutteksponenten
        LSR r5, r5, r6
        

    @ 5
    @ Summere desimalene.
    ADD r8, r4, r5

    @ 4
    @ Normalisere resultatet hvis nødvendig. (høyre skift desimalen og øk eksponenten med 1)
    @ hvis siffer 24 fra venstre er 1, må det høyreskiftes
    LSR r7, r8, #24
    CMP r7, #1
    BNE hopp2
        LSR r8, r8, #1
        ADD r9, r9, #1
    hopp2:

    @ 7
    @ Fjerne ledende 1 fra den nye desimalen og konstruere det nye flyttallet med fortegn, eksponent og desimal.
    @ maske: 0 00000001 00000000000000000000000 = 0x800000
    LDR r10, =#0x800000
    BIC r8, r8, r10
    @ må flytte eksponenten opp til de mest signifikante bitsene (utenom det aller mest signifikante)
    LSL r9, r9, #23
    @ legger inn desimalen i sluttresultatet (saemmen med desimalen og en 0 som MSB, siden det er positivt)
    @ maske: 0 11111111 00000000000000000000000 = 0x7F800000
    ORR r9, r8, r9

    @ 8
    @ Legg resultatet i r0.
    MOV r0, r9


    @ When done, return3f800000
    BX lr
    