	processor	pic16f690
	include		<p16f690.inc>

	global		loopback_piso

	extern		clear_piso

;;	Remove following after test
	extern		load_piso

	extern		mv_w_tx
	extern		mv_rx_w
	extern		push_w_piso
	extern		pop_piso_w

	udata
COUNT	res		1

libsp	code
loopback_piso:
	movlw		.3		;;	<< Prompt
	call		mv_w_tx
	.direct		"c","Control.rx"
	.direct		"c","Control.tx = 0x03"
	call		mv_rx_w
	movwf		COUNT
	xorlw		.0
	skpnz
	goto		finish
	call		clear_piso
;;	The following instruction simulates the clear_piso
;;	function for the ttl165 model of gpsim, but must
;;	be removed upon test completion:
	call		load_piso
push:
	movlw		.4		;;	<< Prompt
	call		mv_w_tx
	.direct		"c","Control.rx"
	.direct		"c","Control.tx = 0xF7"
	call		mv_rx_w
	call		push_w_piso
	call		pop_piso_w
	call		mv_w_tx
	banksel		COUNT
	decfsz		COUNT,1
	goto		push
finish:
	return
	end
