# FreeBSD Port Tools
#
# Makefile
#
# Copyright (c) 2003, Sergei Kolobov
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 
# $Id$
# 

# Package name and version
PORTNAME=	porttools
PORTVERSION=	0.01
DISTNAME=	${PORTNAME}-${PORTVERSION}

# Installation prefix (defaults to /usr/local)
PREFIX?=	/usr/local
BINDIR?=	${PREFIX}/bin
DATADIR?=	${PREFIX}/share/${PORTNAME}
DOCSDIR?=	${PREFIX}/share/doc/${PORTNAME}

# Scripts to install
SCRIPTS=	pr-new pr-update testport

# send-pr(1) form template
TEMPLATE=	send-pr.template

# Documentation files
DOCS=		LICENSE README TODO 

# All distribution files
DIST=		Makefile ${SCRIPTS} ${TEMPLATE} ${DOCS}

# No build required
build:
	@echo "No build required. Use 'make install' to install."

# Installation
install:
	test -d ${BINDIR} || mkdir -p ${BINDIR}
	${INSTALL_SCRIPT} ${SCRIPTS} ${BINDIR}
	test -d ${DATADIR} || mkdir -p ${DATADIR}
	${INSTALL_DATA} ${TEMPLATE} ${DATADIR}
.if !defined(NOPORTDOCS)
	test -d ${DOCSDIR} || mkdir -p ${DOCSDIR}
	${INSTALL_DATA} ${DOCS} ${DOCSDIR}
.endif

# Making a new release
release:
	rm -rf ${DISTNAME}
	mkdir ${DISTNAME}
	cp ${DIST} ${DISTNAME}
	tar cvzf ${DISTNAME}.tar.gz ${DISTNAME}
	rm -rf ${DISTNAME}
