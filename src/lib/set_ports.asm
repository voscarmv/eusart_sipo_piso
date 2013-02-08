	processor	pic16f690
	include		<p16f690.inc>

	global		set_ports

	extern		set_anselh_ansel
	extern		set_pinout_tris
	extern		set_eusart_19200

libsp	code
set_ports:
	call		set_anselh_ansel	;;	<< Initial pinout / EUSART settings
	call		set_pinout_tris		;;	<<
	call		set_eusart_19200	;;	<<
	return
	end
