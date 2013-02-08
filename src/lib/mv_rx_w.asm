	processor	pic16f690
	include		<p16f690.inc>

	global		mv_rx_w

libsp	code
mv_rx_w:
	banksel		PIR1		;;	<< Pause execution until a whole byte
	btfss		PIR1,5		;;	<< has been received and stored in register
	goto		$-1		;;	<< RCREG via RX (RB5, pin 12)

	banksel		RCREG		;;	<< Store the contents of RCREG in WREG.
	movfw		RCREG		;;	<<
	return
	end
