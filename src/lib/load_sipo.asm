	processor	pic16f690
	include		<p16f690.inc>

	global		load_sipo

libsp	code
load_sipo:
	banksel		PORTC
	bcf		PORTC,5
	bsf		PORTC,5
	bcf		PORTC,5
	return
	end
