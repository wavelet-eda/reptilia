	.file	"cvectest.c"
	.option nopic
	.text
	.section	.rodata
	.align	2
.LC0:
	.word	1
	.word	1
	.word	1
	.word	1
	.align	2
.LC1:
	.word	1
	.word	2
	.word	3
	.word	4
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sw	s0,76(sp)
	addi	s0,sp,80
	sw	a0,-68(s0)
	sw	a1,-72(s0)
	lui	a5,%hi(.LC0)
	lw	a2,%lo(.LC0)(a5)
	addi	a4,a5,%lo(.LC0)
	lw	a3,4(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a4,8(a4)
	addi	a5,a5,%lo(.LC0)
	lw	a5,12(a5)
	sw	a2,-40(s0)
	sw	a3,-36(s0)
	sw	a4,-32(s0)
	sw	a5,-28(s0)
	lui	a5,%hi(.LC1)
	lw	a2,%lo(.LC1)(a5)
	addi	a4,a5,%lo(.LC1)
	lw	a3,4(a4)
	addi	a4,a5,%lo(.LC1)
	lw	a4,8(a4)
	addi	a5,a5,%lo(.LC1)
	lw	a5,12(a5)
	sw	a2,-56(s0)
	sw	a3,-52(s0)
	sw	a4,-48(s0)
	sw	a5,-44(s0)
	li	a5,2
	sw	a5,-20(s0)
	li	a5,9
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "cvectest.c" 1
	vsetvl a5, a5;
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
 #APP
# 13 "cvectest.c" 1
	vfence;
# 0 "" 2
 #NO_APP
	li	a5,0
	mv	a0,a5
	lw	s0,76(sp)
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.0"
