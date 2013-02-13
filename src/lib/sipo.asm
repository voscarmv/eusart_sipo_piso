	processor	pic16f690
	include		<p16f690.inc>

	extern		mv_w_tx
	extern		mv_rx_w
	extern		mv_w_sipo
	extern		load_sipo
	extern		clear_sipo

	global		sipo

	udata
COUNT	res		1

libsp	code
sipo:
	movlw		.0
;;	.direct		"c", "U1.rx"
	call		mv_w_tx
;;	.direct		"c", "U1.tx=0x02"
	call		mv_rx_w
	movwf		COUNT
	xorlw		.0
	skpnz
	goto		finish
	call		clear_sipo
ser_out:
	movlw		.1
;;	.direct		"c", "U1.rx"
	call		mv_w_tx
;;	.direct		"c", "U1.tx=0xF0"
	call		mv_rx_w
	call		mv_w_sipo
	decfsz		COUNT,1
	goto		ser_out
	call		load_sipo
finish:
	return
	end
