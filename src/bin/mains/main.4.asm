	processor	pic16f690
	include		<p16f690.inc>
	include		<config.inc>

	extern		set_ports
	extern		greet
	extern		mv_rx_w
	extern		mv_w_tx
	extern		sipo
	extern		piso
	extern		loopback_sipo
	extern		loopback_piso

start	code		H'0000'
	call		set_ports
	goto		main

	udata
SIG	res		1

prog	code
main:
;;	Prompt bytes sent by Interface:
;;	Byte	Signal			Function
;;	.13	Main Prompt		First prompt after greet
;;					This prompt indicates that Interface is ready to
;;					receive the selector signal from Control.
;;	.0	SIPO Prompt		Interface is ready to receive the number of bytes
;;					to be sent into SIPO (74595)
;;					If Control sends Interface a .0 here, Interface
;;					goes back to the Main Prompt.
;;	.1	SIPO byte Prompt	Interface is ready to receive the next byte to be
;;					pushed into the SIPO daisychain.
;;	.2	PISO Prompt		Interface is ready to receive the number of bytes
;;					to be sent to Control from PISO (74597)
;;					If Control sends .0 to Interface, Interface goes
;;					back to Main Prompt
;;	.3	loopback PISO Prompt	Interface is ready to receive the number of bytes
;;					to be sent from Control to PISO for the loopback
;;					daisychain test.
;;					If Control sends .0, Interface goes back to the
;;					Main Prompt
;;	.4	lo PISO byte Prompt	Interface is ready to receive a byte to push into
;;					the PISO loopback daisychain.
;;					After receiving such a byte, Interface sends the
;;					byte popped from the other side of the daisychain
;;					to Control.
;;	.5	loopback SIPO Prompt	Interface is ready to receive the number of bytes
;;					to be sent from Control to SIPO for the loopback
;;					daisychain test.
;;					If Control sends .0, Interface goes back to the
;;					Main Prompt
;;	.6	lo SIPO byte Prompt	Interface is ready to receive a byte to push into
;;					the SIPO loopback daisychain.
;;					After receiving such byte, Interface sends the byte
;;					popped from the other side of the daisychain to
;;					Control.

;;	Bytes .7 through .12 are reserved for the greet subroutine
;;	From those, .7, .9 and .11 come from Interface
;;	whereas .8, .10 and .12 come from Control

;;	Command bytes sent by Control:
;;	Byte	Signal			Function
;;	.14	Select PISO function	Request the PISO prompt from Interface.
;;					Presume .2 byte reply from Interface.
;;	.15	Select SIPO funciton	Request the SIPO prompt from Interface.
;;					Presume .0 byte reply from Interface.
;;	.16	Select lo PISO function	Request loopback PISO prompt from Interface.
;;					Presume .3 byte reply from Interface.
;;	.17	Select lo SIPO function	Request loopback SIPO prompt from Interface.
;;					Presume .5 byte reply from Interface.
;;	.18	Return to greet		Go back to greet subroutine, before ending a
;;					typical communications session.

;;	Argument bytes sent by Control:
;;	Byte	Signal			Function
;;	x00	Exit from prompt	Exit from prompts...
;;						.0	SIPO Prompt
;;						.2	PISO Prompt
;;						.3	loopback PISO Prompt
;;						.5	loopback SIPO Prompt
;;					...into the Main Prompt.
;;	x01-xFF	Set number of bytes	Set amount of bytes when in prompts:
;;						.0	SIPO Prompt
;;						.2	PISO Prompt
;;						.3	loopback PISO Prompt
;;						.5	loopback SIPO Prompt
;;	x00-xFF	Choose byte to push	Push byte from set {0x00-0xFF} when in prompts:
;;						.1	SIPO byte prompt
;;						.4	lo PISO byte Prompt
;;						.6	lo SIPO byte Prompt

	call		greet

prompt13:
	movlw		.13		;;	<< Main Prompt
	call		mv_w_tx

	call		mv_rx_w
	banksel		SIG
	movwf		SIG
	xorlw		.14
	skpz
	goto		fi1
;;
;;	if SIGNAL == "Select PISO function" ; then
;;
	call		piso		;;	<< Execute PISO session
	goto		prompt13
;;
;;	fi
;;
fi1:

	banksel		SIG
	movfw		SIG
	xorlw		.15
	skpz
	goto		fi2
;;
;;	if SIGNAL == "Select SIPO function" ; then
;;
	call		sipo		;;	<< Execute SIPO session
	goto		prompt13
;;
;;	fi
;;
fi2:

	banksel		SIG
	movfw		SIG
	xorlw		.16
	skpz
	goto		fi3
;;
;;	if SIGNAL == "Select loopback PISO function" ; then
;;
	call		loopback_piso	;;	<< Execute loopback PISO session
	goto		prompt13
;;
;;	fi
;;
fi3:

	banksel		SIG
	movfw		SIG
	xorlw		.17
	skpz
	goto		fi4
;;
;;	if SIGNAL == "Select loopback SIPO function" ; then
;;
	call		loopback_sipo	;;	<< Execute looback PISO session
	goto		prompt13
;;
;;	fi
;;
fi4:

	banksel		SIG
	movfw		SIG
	xorlw		.18
	skpnz
;;
;;	if SIGNAL == "Return to greet" ; then
;;
	goto		main		;;	<< Go back to the start
;;
;;	fi
;;

	movlw		.255		;;	<< Send "Command not found" to Control
	call		mv_w_tx

	goto		prompt13

aa:
	goto		aa
	end
