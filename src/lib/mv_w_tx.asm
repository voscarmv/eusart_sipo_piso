	processor	pic16f690
	include		<p16f690.inc>

	global		mv_w_tx

libsp	code
mv_w_tx:
	banksel		TXREG		;;	<< Move the contents of WREG to TXREG
	movwf		TXREG		;;	<<

	nop				;;	<< Wait for TRMT to be cleared
	nop				;;	<<

	banksel		TXSTA		;;	<< Pause execution until TRMT (TXSTA,1)
	btfss		TXSTA,1		;;	<< is set again. i.e. until the byte
	goto		$-1		;;	<< transmission completes
	return
	end
