	processor	pic16f690
	include		<p16f690.inc>

	global		loopback_sipo

	extern		clear_sipo
	extern		mv_w_tx
	extern		mv_rx_w
	extern		push_w_sipo
	extern		pop_sipo_w

	udata
COUNT	res		1

libsp	code
loopback_sipo:
	movlw		.5		;;	<< Prompt
	call		mv_w_tx
	call		mv_rx_w
	movwf		COUNT
	xorlw		.0
	skpnz
	goto		finish
	call		clear_sipo
push:
	movlw		.6		;;	<< Prompt
	call		mv_w_tx
	call		mv_rx_w
	call		push_w_sipo
	call		pop_sipo_w
	call		mv_w_tx
	banksel		COUNT
	decfsz		COUNT,1
	goto		push
;;	goto		loopback_sipo
finish:
	return
	end
