# FreeBSD Port Tools
#
# Makefile
# 
# $Id$
# 

# Package name and version
PORTNAME=	porttools
PORTVERSION=	0.20
DISTNAME=	${PORTNAME}-${PORTVERSION}

SCRIPTS=	pr-update testport
DOCS=		LICENSE NEWS README THANKS TODO 

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
.for file in ${SCRIPTS} ${DOCS}
	sed -e 's/__VERSION__/${PORTVERSION}/' ${file} > ${DISTNAME}/${file}
.endfor
	tar cvzf ${DISTNAME}.tar.gz ${DISTNAME}
	rm -rf ${DISTNAME}

# Updating TODO
TODO: .todo Makefile
	devtodo --filter -done,+children --TODO
