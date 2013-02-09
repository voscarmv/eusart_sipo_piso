#	Change variables:
#		objects
#		objname
#		libname
#		includes
#	for a different project of the same form.

#
#	Variables:
#

libdir = ./bin/lib
bindir = ./bin/bin
incdir = ./bin/include

src_libdir = ./src/lib
src_bindir = ./src/bin
src_incdir = ./src/include

objects := \
	${libdir}/mv_rx_w.o \
	${libdir}/mv_w_tx.o \
	${libdir}/set_ports.o \
		${libdir}/set_anselh_ansel.o \
		${libdir}/set_pinout_tris.o \
		${libdir}/set_eusart_19200.o

objname = sipo_piso
libname = libsp

mainobj := ${bindir}/main_${objname}.o
mosrc := ${src_bindir}/main_${objname}.asm
moincludes := \
	${incdir}/config.inc \
	${incdir}/signals.inc
modeps := ${mosrc} ${moincludes}

mainlibs := ${libdir}/${libname}.a
maindeps := ${mainobj} ${mainlibs}

script = /usr/share/gputils/lkr/16f690.lkr

output := ${bindir}/${objname}.hex

stc = ./simu/sim1.stc

#
#	Paths:
#

vpath %.inc ${src_incdir}
vpath %.asm ${src_libdir}

#
#	Main target:
#

all : ${output}

${output} : ${maindeps} ${script}
	gplink -m -o ${@} -s ${script} ${maindeps}

#
#	Main object:
#

${mainobj} : ${modeps}
	gpasm -c -o ${@} -I${incdir} ${<}

${moincludes} : ${incdir}/%.inc : %.inc
	cp ${<} ${@}

#
#	Libraries:
#

${mainlibs} : ${objects}
	test -e ${@} || gplib -c ${@} ${^} && gplib -r ${@} ${?}

${objects} : ${libdir}/%.o : %.asm
	gpasm -c -o ${@} -I${incdir} ${<}

#
#	Phonies:
#

sim :
	test -e ${bindir}/${objname}.cod && \
	gpsim -L. -pp16f690 -s ${bindir}/${objname}.cod -c ${stc}

erase :
	pk2cmd -E -B/usr/share/pk2 -PPIC16F690 

prog :
	pk2cmd -M -B/usr/share/pk2 -PPIC16F690 -F${output}

run :
	pk2cmd -PPIC16F690 -B/usr/share/pk2 -A5 -T

stop :
	pk2cmd -PPIC16F690 -B/usr/share/pk2 -R

clean :
	rm ${libdir}/* ${incdir}/* ${bindir}/*
