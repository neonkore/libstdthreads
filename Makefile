LIB=	stdthreads

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

.include <bsd.lib.mk>
