;;	Push a byte into SIPO daisychain, bit by bit. At the same time,
;;	with each pushed bit, record the popped bit on the other side of
;;	the daisychain, into a 1 byte register, until this register is
;;	filled.
	processor	pic16f690
	include		<p16f690.inc>

	variable	i

	global		push_w_sipo
	global		FRSIPO

	udata
TOSIPO	res		1
FRSIPO	res		1

libsp	code
push_w_sipo:
;;	This is pretty much the same as mv_w_sipo, except that with an
;;	interwined read function to record one bit at a time from the
;;	serial input terminal.

;;	Transmit the contents of WREG through DOSIPO synchronously with CKSIPO,
;;	storin theg the byte received through DISIPO in FRSIPO global register.

;;	PORT	PIN	I/O	NAME	FUNCTION
;;	RA5	2	O	DOSIPO	Ser data out
;;	RA4	3	O	CKSIPO	Clock out
;;	RA3	4	I	DISIPO	Ser data in

	banksel		PORTA
	bcf		PORTA,5
	bcf		PORTA,4
	bcf		PORTA,3

	movwf		TOSIPO
	clrf		FRSIPO

i = 8
	while		i > 0

	btfsc		TOSIPO,i-1
	bsf		PORTA,5
	btfss		TOSIPO,i-1
	bcf		PORTA,5

	btfsc		PORTA,3
	bsf		FRSIPO,i-1
	btfss		PORTA,3
	bcf		FRSIPO,i-1

	bsf		PORTA,4
	bcf		PORTA,4

i -= 1
	endw

	return
	end
