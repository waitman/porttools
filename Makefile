# FreeBSD Port Tools
#
# Makefile
# 
# $Id$
# 

# Package name and version
PORTNAME=	porttools
PORTVERSION=	0.25
DISTNAME=	${PORTNAME}-${PORTVERSION}

SCRIPTS=	pr-update testport
DOCS=		LICENSE NEWS README THANKS TODO 
MAN1=		pr-change.1 pr-new.1 pr-update.1 testport.1

##
## Maintainer only
##

# Making a new release
release: ${DISTNAME}.tar.gz
	
upload: ${DISTNAME}.tar.gz
	sfupload ${DISTNAME}.tar.gz
	mv ${DISTNAME}.tar.gz /FreeBSD/distfiles

${DISTNAME}.tar.gz: ${SCRIPTS} ${DOCS}
	rm -rf ${DISTNAME}
	mkdir ${DISTNAME}
.for file in ${SCRIPTS}
	sed -e 's/__VERSION__/${PORTVERSION}/' ${file} > ${DISTNAME}/${file}
.endfor
	cp ${DOCS} ${MAN1} ${DISTNAME}
	tar cvzf ${DISTNAME}.tar.gz ${DISTNAME}
	rm -rf ${DISTNAME}

# Updating TODO
TODO: .todo Makefile
	devtodo --filter -done,+children --TODO
