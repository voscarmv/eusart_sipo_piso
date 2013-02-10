	processor	pic16f690
	include		<p16f690.inc>

	extern		mv_w_tx
	extern		mv_rx_w
	extern		mv_w_sipo
	extern		load_sipo
	extern		clear_sipo

	global		sipo

	udata
NBYTES	res		1

libsp	code
sipo:
	movlw		.0
	call		mv_w_tx
	call		mv_rx_w
	movwf		NBYTES
	xorlw		.0
	skpnz
	goto		finish
	call		clear_sipo
ser_out:
	movlw		.1
	call		mv_w_tx
	call		mv_rx_w
	call		mv_w_sipo
	decfsz		NBYTES,1
	goto		ser_out
	call		load_sipo
finish:
	return
	end
