	processor	pic16f690
	include		<p16f690.inc>

	variable	i

	global		mv_piso_w

	udata
FRMPISO	res		1
libsp	code
mv_piso_w:
;;	Receive 1 byte from PISO by popping 8 bits into DIPISO with CKPISO

;;	PORT	PIN	I/O	NAME	FUNCTION
;;	RA0	19	I	DIPISO	Ser data in
;;	RA2	17	O	CKPISO	Clock out

	banksel		PORTA		;;	<< Prepare for synchronous reception of
	bcf		PORTA,0		;;	<< data through DIPISO with CKPISO
	bcf		PORTA,2		;;	<<

i=8					;;	<< Begin synchronous reception loop
	while		i > 0		;;	<< of 8 bits.

	btfsc		PORTA,0		;;	<< If DIPISO is 0, clear bit i from
	bsf		FRMPISO,i-1	;;	<< FRMPISO. Else, set bit i.
	btfss		PORTA,0		;;	<<
	bcf		FRMPISO,i-1	;;	<<

	bsf		PORTA,2		;;	<< Pop next bit from PISO into DIPISO
	bcf		PORTA,2		;;	<< with a pulse on CKPISO

i -= 1					;;	<< End synchronous reception loop
	endw				;;	<<

	movfw		FRMPISO		;;	<< Move stored PISO byte from FMPISO
					;;	   to WREG

	return
	end
