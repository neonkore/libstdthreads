LIB=	stdthreads
PACKAGE_VERSION?=	0.2
PREFIX?=	/usr

HDR=	threads.h
SRCS=	threads.h call_once.c cnd.c mtx.c thrd.c tss.c

MAN=	thrd_create.3

CPPFLAGS+=	-Wno-incompatible-pointer-types-discards-qualifiers
LDADD=	-L${BSDOBJDIR}/lib/librthread -lpthread

VERSION_SCRIPT= ${.CURDIR}/Symbol.map

includes:
	@cd ${.CURDIR}; j="cmp -s ${HDR} ${DESTDIR}/usr/include/${HDR} || \
                ${INSTALL} ${INSTALL_COPY} -o ${BINOWN} -g ${BINGRP} \
                -m 444 ${HDR} ${DESTDIR}/usr/include"; \
            echo $$j; \
            eval "$$j"; \

stdthreads.pc: stdthreads.pc.in
	@sed -e 's#@prefix@#${PREFIX}#g' \
		-e 's#@exec_prefix@#$${prefix}#g' \
		-e 's#@libdir@#$${exec_prefix}/lib#g' \
		-e 's#@includedir@#$${prefix}/include#g' \
		-e 's#@PACKAGE_VERSION@#'${PACKAGE_VERSION}'#g' \
	< ${.CURDIR}/stdthreads.pc.in > $@

all:	stdthreads.pc

CLEANFILES+=	stdthreads.pc

install-pc:	stdthreads.pc
	${INSTALL} ${INSTALL_COPY} -o ${BINOWN} -g ${BINGRP} -m 444 \
		stdthreads.pc ${DESTDIR}${LIBDIR}/pkgconfig

realinstall:	install-pc

.include <bsd.lib.mk>
