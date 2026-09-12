	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"part3.c"
	.text
	.align	1
	.global	_Z3fibj
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	_Z3fibj, %function
_Z3fibj:
	.fnstart
.LFB19:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, #1
	movs	r3, #0
.L3:
	cbz	r0, .L1
	adds	r1, r3, r2
	subs	r0, r0, #1
	mov	r2, r3
	mov	r3, r1
	b	.L3
.L1:
	mov	r0, r3
	bx	lr
	.cantunwind
	.fnend
	.size	_Z3fibj, .-_Z3fibj
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC0:
	.ascii	"%d\012\000"
	.section	.text.startup,"ax",%progbits
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	.fnstart
.LFB20:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
	.save {r3, lr}
	movs	r0, #13
	bl	_Z3fibj(PLT)
	ldr	r1, .L6
.LPIC0:
	add	r1, pc
	mov	r2, r0
	movs	r0, #1
	bl	__printf_chk(PLT)
	movs	r0, #0
	pop	{r3, pc}
.L7:
	.align	2
.L6:
	.word	.LC0-(.LPIC0+4)
	.fnend
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
