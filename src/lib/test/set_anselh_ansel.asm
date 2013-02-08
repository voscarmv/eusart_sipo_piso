	processor	pic16f690
	include		<p16f690.inc>

	global		set_anselh_ansel

libsp	code
set_anselh_ansel:
	banksel		ANSEL		;;	<< ANSELH:ANSEL Settings
	clrf		ANSEL		;;	<<
	banksel		ANSELH		;;	<<
	clrf		ANSELH		;;	<<
	return
	end
