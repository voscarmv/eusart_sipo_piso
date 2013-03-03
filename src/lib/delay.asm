	processor	pic16f690
	include		<p16f690.inc>

	global		delay

	udata
CTR1	res		1
CTR2	res		1

libsp	code
delay:
	banksel		CTR1
	movlw		.255
	movwf		CTR1
	movlw		.3
	movwf		CTR2
loop1:
	decfsz		CTR1,1
	goto		loop2
	goto		finish
loop2:
	decfsz		CTR2,1
	goto		loop2
	goto		loop1
finish:
	return
	end
