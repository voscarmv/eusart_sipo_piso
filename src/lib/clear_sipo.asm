	processor	pic16f690
	include		<p16f690.inc>

	global		clear_sipo

libsp	code
clear_sipo:
	banksel		PORTC
	bsf		PORTC,4
	bcf		PORTC,4
	bsf		PORTC,4
	return
	end
