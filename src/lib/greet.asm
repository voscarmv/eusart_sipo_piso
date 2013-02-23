	processor	pic16f690
	include		<p16f690.inc>

	extern		mv_rx_w
	extern		mv_w_tx

	global		greet

	udata
FLAGS	res		1
GSIG	res		1

libsp	code
greet:
;;	Signals:
;;	Byte	Signal			Function
;;	.7	Interface-distress	Send to Control, expect Control-response
;;	.8	Control-response	Send to Interface after receiving Interface-distress
;;					and expect Interface-confirm
;;	.9	Interface-confirm	Send to Control after receiving Control-response
;;	.10	Control-distress	Send to Interface, expect Interface-response
;;	.11	Interface-response	Send to Control after receiving Control-distress
;;					and expect Control-confirm
;;	.12	Control-confirm		Send to Interface after receiving Interface-response

;;	Flags:
;;	(All flags are set by default)
;;	Bit	Flag			Function
;;	0	C_DISTRESS_PENDING	Interface is expecting Control-distress.
;;					Therefor: C_DISTRESS_PENDING = 1
;;					When Control-distress is received, this is unset.
;;	1	C_RESPONSE_PENDING	Interface-distress was sent AND received by Control,
;;					Interface is now expecting a Control-response signal
;;					Therefor: C_RESPONSE_PENDING = 1
;;					When Control-response is received, this is unset.
;;	2	C_CONFIRM_PENDING	Control-distress was received and responded by
;;					Interface with an Interface-response. Interface
;;					is therefor expecting a Control-confirm.
;;					Therefor: C_CONFIRM_PENDING = 1
;;					When Control-confirm is received, this is unset.
;;	3	ITX_IRX			Interface-distress was sent and Control-response
;;					was received in exchange. Interface-confirm will be
;;					sent to Control.
;;					Therefor: ITX_IRX = 0
;;					Otherwise, this is set.
;;	4	CTX_CRX			Control-distress was received and responded with
;;					Interface-response by Interface. Then, Control
;;					sent Control-confirm and Interface received this.
;;					Therefor: CTX_CRX = 0
;;					Otherwise, this is set.

;;	It can be said that ITX_IRX=0 only when C_RESPONSE_PENDING is 0, and
;;	CTX_CRX=0 only when C_DISTRESS_PENDING = C_CONFIRM_PENDING = 0

;;	Set flags
	banksel		FLAGS
	movlw		B'00011111'
	banksel		FLAGS
	movwf		FLAGS

;;	Break loop
break:
	banksel		FLAGS
	movfw		FLAGS
	xorlw		.0
	skpnz
	goto		finish

;;	Transmission
transmit:
	banksel		FLAGS
	btfss		FLAGS,1
	goto		else1
;;
;;	if C_RESPONSE_PENDING (FLAGS,1) == 1 ; then
;;
	movlw		.7		;;	<< Send Interface-distress
	call		mv_w_tx
	.direct		"c","Control.rx"
	goto		fi1
;;
;;	else
;;
else1:
	movlw		.9		;;	<< Send Interface-confirm
	call		mv_w_tx
	.direct		"c","Control.rx"
;;
;;	fi
;;
fi1:

	banksel		FLAGS
	movfw		FLAGS
	andlw		B'00000101'
	xorlw		B'00000100'
	skpz
	goto		fi2
;;
;;	if C_DISTRESS_PENDING (FLAGS,0) == 0 && C_CONFIRM_PENDING (FLAGS,2) == 1 ; then
;;
	movlw		.11		;;	<< Send Interface-response
	call		mv_w_tx
	.direct		"c","Control.rx"
;;
;;	fi
;;
fi2:

;;	Sample RX byte
sample:
	.direct		"c","Control.tx=8"
	banksel		PIR1
	btfss		PIR1,5
	goto		break

;;	Reception
receive:
	call		mv_rx_w
	banksel		GSIG
	movwf		GSIG
	xorlw		.10
	skpnz
;;
;;	if SIGNAL == Control-distress ; then
;;
	.direct		"c","Control.tx"
	bcf		FLAGS,0		;;	<< Clear C_DISTRESS_PENDING
;;
;;	fi
;;

	movfw		GSIG
	xorlw		.8
	skpz
	goto		fi3
;;
;;	if SIGNAL == Control-response ; then
;;
	bcf		FLAGS,1		;;	<< Clear C_RESPONSE_PENDING
	bcf		FLAGS,3		;;	<< Clear ITX_IRX
;;
;;	fi
;;
fi3:

	movfw		GSIG
	xorlw		.12
	skpz
	goto		fi4
;;
;;	if SIGNAL == Control-confirm ; then
;;
	bcf		FLAGS,2		;;	<< Clear C_CONFIRM_PENDING
	bcf		FLAGS,4		;;	<< Clear CTX_CRX
;;
;;	fi
;;
fi4:

	goto		break
finish:
	return
	end
