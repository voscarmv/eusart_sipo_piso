;;	push_w_sipo stores the byte popped from the other side of the
;;	daisychain into a register. Well, pop_sipo_w stores that value
;;	in WREG.
	processor	pic16f690
	include		<p16f690.inc>

	global		pop_sipo_w

	extern		FRSIPO

libsp	code
pop_sipo_w:
	banksel		FRSIPO
	movfw		FRSIPO
	return
	end
