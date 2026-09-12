	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"part3.c"
	.text
	.align	1
	.p2align 2,,3
	.global	_Z3fibj
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	_Z3fibj, %function
_Z3fibj:
	.fnstart
.LFB30:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r0, .L4
	movs	r1, #1
	movs	r3, #0
.L3:
	adds	r2, r3, r1
	subs	r0, r0, #1
	mov	r1, r3
	mov	r3, r2
	bne	.L3
	mov	r0, r2
	bx	lr
.L4:
	mov	r2, r0
	mov	r0, r2
	bx	lr
	.cantunwind
	.fnend
	.size	_Z3fibj, .-_Z3fibj
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%d\012\000"
	.section	.text.startup,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	.fnstart
.LFB31:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L9
	movs	r2, #233
	push	{r3, lr}
	.save {r3, lr}
.LPIC0:
	add	r1, pc
	movs	r0, #1
	bl	__printf_chk(PLT)
	movs	r0, #0
	pop	{r3, pc}
.L10:
	.align	2
.L9:
	.word	.LC0-(.LPIC0+4)
	.fnend
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
