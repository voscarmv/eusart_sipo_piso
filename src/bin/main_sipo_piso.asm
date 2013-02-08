	processor	pic16f690
	include		<p16f690.inc>
	include		<coff.inc>
	include		<config.inc>
	include		<signals.inc>

	extern		set_ports
	extern		mv_rx_w
	extern		mv_w_tx

start	code		H'0000'
	goto		main

prog	code
main:
	call		set_ports
	.direct		"c","U1.tx=55"
	call		mv_rx_w
	call		mv_w_tx
	movlw		B'10000001'
	call		mv_w_tx
aa:
	goto		aa
	end
