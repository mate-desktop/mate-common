#!/bin/sh

if [ -x /usr/bin/txt2man ]; then

	txt2man \
		-d "`date -R`" \
		-P mate-autogen \
		-t mate-autogen \
		-s 1 \
		mate-autogen.txt > mate-autogen.1

	txt2man \
		-d "`date -R`" \
		-P mate-doc-common \
		-t mate-doc-common \
		-s 1 \
		mate-doc-common.txt > mate-doc-common.1

else

	echo "Install txt2man package to update manpages"

fi
