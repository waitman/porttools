# FreeBSD Port Tools
#
# Makefile
# 
# $Id$
# 

# Package name and version
PORTNAME?=	porttools
PORTVERSION?=	0.50
DISTNAME?=	${PORTNAME}-${PORTVERSION}

PROGRAMS=	port
SCRIPTS=	cmd_create cmd_diff cmd_fetch cmd_help \
	 	cmd_submit cmd_test util_diff
DOCS=		LICENSE NEWS README THANKS TODO 
MAN1=		port.1 
MAN5=		porttools.5 

# Normally provided via bsd.port.mk infrastructure
PREFIX?=	/pkg
DATADIR?=	${PREFIX}/share/${PORTNAME}
DOCSDIR?=	${PREFIX}/share/doc/${PORTNAME}

BSD_INSTALL_SCRIPT?=	install -m 555
BSD_INSTALL_DATA?=	install -m 444
BSD_INSTALL_MAN?=	install -m 444

# Targets
all: ${PROGRAMS} ${SCRIPTS} Makefile

.SUFFIXES: .in

.in: 
	sed -e 's,__VERSION__,${PORTVERSION},;s,__PREFIX__,${PREFIX},' \
		inc_header.in ${.IMPSRC} > ${.TARGET}
	chmod a+x ${.TARGET}

install:
	${BSD_INSTALL_SCRIPT} ${PROGRAMS} ${PREFIX}/bin
	mkdir -p ${DATADIR}
	${BSD_INSTALL_SCRIPT} ${SCRIPTS} ${DATADIR}
	mkdir -p ${MANPREFIX}/man/man1
	${BSD_INSTALL_MAN} ${MAN1} ${MANPREFIX}/man/man1
	mkdir -p ${MANPREFIX}/man/man5
	${BSD_INSTALL_MAN} ${MAN5} ${MANPREFIX}/man/man5

install-docs:
	mkdir -p ${DOCSDIR}
	${BSD_INSTALL_DATA} ${DOCS} ${DOCSDIR}

clean:
	rm -rf ${PROGRAMS} ${SCRIPTS} ${DISTNAME}*

##
## Maintainer section
##
release: ${DISTNAME}.tar.gz
	
upload: ${DISTNAME}.tar.gz Makefile
	sfupload ${DISTNAME}.tar.gz
	mv ${DISTNAME}.tar.gz /FreeBSD/distfiles

${DISTNAME}.tar.gz: ${PROGRAMS} ${SCRIPTS} Makefile
	rm -rf ${DISTNAME}
	mkdir ${DISTNAME}
	cp Makefile *.in ${DOCS} ${MAN1} ${MAN5} .todo ${DISTNAME}
	tar cvzf ${DISTNAME}.tar.gz ${DISTNAME}
	rm -rf ${DISTNAME}

TODO: .todo Makefile
	devtodo --filter -done,+children --TODO
