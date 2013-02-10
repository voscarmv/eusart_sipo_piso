	processor	pic16f690
	include		<p16f690.inc>

	global		load_piso

libsp	code
load_piso:
	banksel		PORTC
	bcf		PORTC,0
	bsf		PORTC,0
	bcf		PORTC,0
	bsf		PORTC,2
	bcf		PORTC,2
	bsf		PORTC,2
	return
	end
