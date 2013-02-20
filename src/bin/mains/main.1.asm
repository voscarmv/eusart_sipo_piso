	processor	pic16f690
	include		<p16f690.inc>
	include		<coff.inc>
	include		<config.inc>
	include		<signals.inc>

	extern		set_ports
	extern		mv_rx_w
	extern		mv_w_tx
	extern		sipo
	extern		piso

start	code		H'0000'
	call		set_ports
	goto		main

prog	code
main:
	call		sipo
	call		piso
aa:
	goto		aa
	end
