	processor	pic16f690
	include		<p16f690.inc>

	variable	i

	global		mv_w_sipo

	udata
TOSIPO	res		1

libsp	code
mv_w_sipo:
;;	Transmit the contents of WREG through DOSIPO synchronously with CKSIPO

;;	PORT	PIN	I/O	NAME	FUNCTION
;;	RA5	2	O	DOSIPO	Ser data out
;;	RA4	3	O	CKSIPO	Clock out

	banksel		PORTA		;;	<< Prepare to send synchronous data
	bcf		PORTA,5		;;	<< through DOSIPO with CKSIPO.
	bcf		PORTA,4		;;	<<

	movwf		TOSIPO		;;	<< Move the contents of WREG to TOSIPO
					;;	   to transmit it synchronously

i = 8					;;	<< Begin synchronous transmission loop
	while		i > 0		;;	<< of 8 bits.

	btfsc		TOSIPO,i-1	;;	<< If bit i-1 is 0, clear DOSIPO, else
	bsf		PORTA,5		;;	<< set DOSIPO.
	btfss		TOSIPO,i-1	;;	<<
	bcf		PORTA,5		;;	<<

	bsf		PORTA,4		;;	<< Push DOSIPO bit into the SIPO shift
	bcf		PORTA,4		;;	<< register with a pulse on CKSIPO

i -= 1					;;	<< End synchronous transmission loop 
	endw				;;	<<

	return
	end
