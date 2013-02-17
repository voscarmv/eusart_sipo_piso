#!/bin/bash
# Horizontal difference: 48 132
#	132-48=84
# Next	216
# Vertical difference: 504 564
#	564-504=60
# Next	624
# Max xpos: 720

INPUT='	module load switch I1A
		I1A.xpos = 432
		I1A.ypos = 420

		module load pullup U1A
			U1A.xpos = 48
			U1A.ypos = 504

		module load pulldown D1A
			D1A.xpos = 48
			D1A.ypos = 564

		node N_I1_A_PU N_I1_A_PD
			attach N_I1_A_PU U1A.pin I1A.A
			attach N_I1_A_PD D1A.pin I1A.B PISO1.D0'

CTR=432
CTR2=0
CTR3=636
CTR4=720
CTR5=564
CTR6=564
for i in A B C D E F G H ; do
	printf %s "${INPUT}" | \
	sed	'	s/U1A\.xpos = 48/U1A.xpos = '"${CTR3}"'/;
			s/U1A\.ypos = 504/U1A.ypos = '"${CTR5}"'/;
			s/D1A\.xpos = 48/D1A.xpos = '"${CTR4}"'/;
			s/D1A\.ypos = 564/D1A.ypos = '"${CTR6}"'/;
			s/I1A/I2'"${i}"'/g;
			s/D1A/D2'"${i}"'/g;
			s/U1A/U2'"${i}"'/g;
			s/I1_A/I2_'"${i}"'/g;
			s/I2'"${i}"'\.xpos = 432/I2'"${i}"'.xpos = '"${CTR}"'/;
			s/PISO1\.D0/PISO2.D'"${CTR2}"'/'
	CTR3=`expr ${CTR4} + 84`
	if test ${CTR3} -gt 720 ; then
		CTR3=48
		CTR5=`expr ${CTR5} + 60`
		CTR6=`expr ${CTR6} + 60`
	fi
	if test ${CTR6} -gt ${CTR5} ; then
		CTR5=`expr ${CTR5} + 60`
	fi
	CTR4=`expr ${CTR3} + 84`
	if test ${CTR4} -gt 720 ; then
		CTR4=48
		CTR6=`expr ${CTR6} + 60`
	fi
	CTR=`expr ${CTR} - 60`
	CTR2=`expr ${CTR2} + 1`
	echo
	echo
done
