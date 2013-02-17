	processor	pic16f690
	include		<p16f690.inc>

	extern		mv_w_tx
	extern		mv_rx_w
	extern		mv_piso_w
	extern		load_piso
	extern		clear_piso

	global		piso

	udata
COUNT	res		1

libsp	code
piso:
	movlw		.2
	call		mv_w_tx
	.direct		"c","Control.tx = 0x02"
	call		mv_rx_w
	movwf		COUNT
	xorlw		.0
	skpnz
	goto		finish
	call		load_piso
ser_in:
	call		mv_piso_w
	call		mv_w_tx
	banksel		COUNT
	decfsz		COUNT,1
	.direct		"c","Control.rx"
	goto		ser_in
finish:
	return
	end
