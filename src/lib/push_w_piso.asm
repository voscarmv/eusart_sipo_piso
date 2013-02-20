;;	Push a byte into PISO daisychain, bit by bit. At the same time,
;;	with each pushed bit, record the popped bit on the other side of
;;	the daisychain, into a 1 byte register, until this register is
;;	filled.
	processor	pic16f690
	include		<p16f690.inc>

	variable	i

	global		push_w_piso
	global		FRPISO

	udata
TOPISO	res		1
FRPISO	res		1

libsp	code
push_w_piso:
;;	This is pretty much the same as mv_w_sipo, except that with an
;;	interwined read function to record one bit at a time from the
;;	serial input terminal.

;;	Transmit the contents of WREG through DOPISO synchronously with CKPISO,
;;	storin theg the byte received through DIPISO in FRPISO global register.

;;	PORT	PIN	I/O	NAME	FUNCTION
;;	RA1	18	O	DOPISO	Ser data out
;;	RA2	17	O	CKPISO	Clock out
;;	RA0	19	I	DIPISO	Ser data in

	banksel		PORTA
	bcf		PORTA,1
	bcf		PORTA,2
	bcf		PORTA,0

	movwf		TOPISO
	clrf		FRPISO

i = 8
	while		i > 0

	btfsc		TOPISO,i-1
	bsf		PORTA,1
	btfss		TOPISO,i-1
	bcf		PORTA,1

	btfsc		PORTA,0
	bsf		FRPISO,i-1
	btfss		PORTA,0
	bcf		FRPISO,i-1

	bsf		PORTA,2
	bcf		PORTA,2

i -= 1
	endw

	return
	end
