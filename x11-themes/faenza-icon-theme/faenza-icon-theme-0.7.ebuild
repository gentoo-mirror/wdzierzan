# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_P="Faenza_Icons_by_tiheum.zip"

DESCRIPTION="Faenza GNOME icon theme"
HOMEPAGE="http://gnome-look.org/content/show.php/Faenza?content=128143"
SRC_URI="http://www.deviantart.com/download/173323228/${MY_P}"
RESTRICT="fetch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

#S=${WORKDIR}/${MY_P}

pkg_nofetch() {
	einfo "The host in ${SRC_URI} doesn't like wget."
	einfo ""
	einfo "Download from ${SRC_URI} with"
	einfo "    $ wget -U ImWget -O ${DISTDIR}/${MY_P} ${SRC_URI}"
	einfo "or use any other tool you like and place the archive in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	mkdir themes
	cd themes
	echo Untarring Faenza...
	tar xpf "${WORKDIR}/Faenza.tar.gz" || die
	echo Untarring Faenza Dark...
	tar xpf "${WORKDIR}/Faenza-Dark.tar.gz" || die
}

src_install() {
	dodir /usr/share/icons/ || die
	cp -R themes/* "${D}/usr/share/icons/" || die

	dodoc AUTHORS ChangeLog
}
