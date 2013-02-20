;;	push_w_piso stores the byte popped from the other side of the
;;	daisychain into a register. Well, pop_piso_w stores that value
;;	in WREG.
	processor	pic16f690
	include		<p16f690.inc>

	global		pop_piso_w

	extern		FRPISO

libsp	code
pop_piso_w:
	banksel		FRPISO
	movfw		FRPISO
	return
	end
