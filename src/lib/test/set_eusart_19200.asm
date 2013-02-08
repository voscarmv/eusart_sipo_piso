	processor	pic16f690
	include		<p16f690.inc>

	global		set_eusart_19200

libsp	code
set_eusart_19200:
	banksel		INTCON		;;	<< These settings configure interrupt
	bcf		INTCON,7	;;	<< functions for the PIC16F690 EUSART.
	bcf		INTCON,6	;;	<<
	banksel		PIE1		;;	<<
	bcf		PIE1,5		;;	<<

	banksel		SPBRGH		;;	<< These settings assign the following
	clrf		SPBRGH		;;	<< values to the PIC16F690 EUSART:
	banksel		SPBRG		;;	<<
	movlw		D'12'		;;	<< FOSC		= 4 MHz
	movwf		SPBRG		;;	<< SYNC		= 0
	banksel		BAUDCTL		;;	<< BRGH		= 1
	bcf		BAUDCTL,3	;;	<< BRG16	= 0
	banksel		TXSTA		;;	<< SPBRGH:SPBRG	= 12
	bsf		TXSTA,2		;;	<< BR           = 19200
	bcf		TXSTA,4		;;	<< ACTBR        = 19.23 k
	bcf		TXSTA,3		;;	<< ERROR        = 0.16 %
	bsf		TXSTA,5		;;	<<
	bcf		TXSTA,6		;;	<<
	banksel		RCSTA		;;	<<
	bcf		RCSTA,3		;;	<<
	bsf		RCSTA,4		;;	<<
	bcf		RCSTA,6		;;	<<
	bsf		RCSTA,7		;;	<<
	return
	end
