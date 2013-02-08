	processor	pic16f690
	include		<p16f690.inc>

	global		set_pinout_tris

libsp	code
set_pinout_tris:
	banksel		TRISA		;;	<< These settings provide the following
	movlw		B'00001001'	;;	<< configuration for the physical terminals
	movwf		TRISA		;;	<< of the PIC16F690:
	movlw		B'00100000'	;;	<<
	movwf		TRISB		;;	<< PORT	PIN	I/O	NAME	FUNCTION
	movlw		B'00000000'	;;	<< RA3	4	I	DISIPO	Ser data in
	movwf		TRISC		;;	<< RA5	2	O	DOSIPO	Ser data out
	banksel		PORTA		;;	   RA4	3	O	CKSIPO	Clock out
	clrf		PORTA		;;	   RC5	5	O	LDSIPO	Load D out
	clrf		PORTB		;;	   RC4	6	O	CRSIPO	Clear out
	clrf		PORTC		;;	   RA0	19	I	DIPISO	Ser data in
					;;	   RA1	18	O	DOPISO	Ser data out
					;;	   RA2	17	O	CKPISO	Clock out
					;;	   RC0	16	O	LDPISO	Load D out
					;;	   RC1	15	O	CRPISO	Clear out
					;;	   RB5	12	I	RX	RX in
					;;	   RB7	10	O	TX	TX out
	return
	end
