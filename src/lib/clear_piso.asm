	processor	pic16f690
	include		<p16f690.inc>

	global		clear_piso

libsp	code
clear_piso:
	banksel		PORTC
	bsf		PORTC,1
	bcf		PORTC,1
	bsf		PORTC,1
	return
	end
