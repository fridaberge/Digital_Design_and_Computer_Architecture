@ The two numbers we want to add
num1:   .word   0x3f800000
num2:   .word   0x3f800000

.text
.global main
main:
    @ Load numbers
    @0 01111111 00000000000000000000000
    LDR r0, num1
    LDR r1, num2

    @1:
    @Maskere ut og flytte ned eksponenten i begge tall, slik at eksponenten ligger i de minst signifikante bit'ene i registeret.
    @maske: 1 00000000 11111111111111111111111(2) = 0x807FFFFF
    BIC r2, r0, 0x807FFFFF
    BIC r3, r1, 0x807FFFFF
    @r2 og r3: 0 01111111 000000000000000000000
    @flytte ned eksponent til minst signifikante bits
    LSR r2, r2, #23
    LSR r3, r3, #23
    @r2 og r3: 0 00000000 000000000000001111111

    @2
    @Maskere ut desimalen, og legge til et ledende 1 tall.
    @maske: 1 11111111 00000000000000000000000(2) = 0xFF800000
    BIC r4, r0, 0xFF800000
    BIC r5, r1, 0xFF800000
    @r4 og r5: 0 00000000 000000000000000000000
    @maske: 0 00000001 000000000000000000000
    ORR r4, r4, 0x200000
    ORR r5, r5, 0x200000
    @r4 og r5: 0 00000001 000000000000000000000

    @3 og 4
    @Trekke den minste eksponenten fra den største og sette eksponenten til det nye tallet lik den største av de to eksponentene.
    @Høyre skifte desimalen til det minste tallet med forskjellen av eksponentene fra steget over.
    CMP r2, r3
    BPL hopp
    SUB r6, r3, r2
    LSR r4, r4, r6
    hopp: 
        SUB r6, r2, r3
        LSR r5, r5, r6


    @5
    @Summere desimalene.
    ADD r7, r4, r5

    @4
    @Normalisere resultatet hvis nødvendig. (høyre skift desimalen og øk eksponenten med 1)
    @maske: 1 11111101 11111111111111111111111 = 0xFEFFFFFF
    BIC r8, r7, 0xFEFFFFFF
    CMP r8, 0x1000000
    BNE hopp2
        LSR r5, r5, #1
        ADD r6, r6, #1
    hopp2

    @7
    @Fjerne ledende 1 fra den nye desimalen og konstruere det nye flyttallet med fortegn, eksponent og desimal.
    @maske: 1 11111110 11111111111111111111111 = 0xFF7FFFFF
    BIC r5, r5, 0xFF7FFFFF
    @må flytte eksponenten opp til de mest signifikante bitsene (utenom det aller mest signifikante)
    LSL r6, r6, #23
    @legger inn eksponenten i sluttresultatet (sammen med desimalen og en 0 som MSB, siden det er positivt)
    @maske: 0 11111111 00000000000000000000000 = 0x7F800000
    ORR r5, r6, 0x7F800000

    @8
    @Legg resultatet i r0.
    MVN r0, r5


    
    

    


    @ When done, return
    BX lr