book:	book.tex
	#pdflatex book
	#makeindex book.idx
	pdflatex book
	mv book.pdf thinkds.pdf
	evince thinkds.pdf

code:
	cd code; make

hevea:
	sed 's/\(figs\/[^.]*\).pdf/\1.eps/' book.tex > thinkjava.tex
	rm -rf html
	mkdir html
	hevea -O -e latexonly htmlonly thinkjava
	hevea -O -e latexonly htmlonly thinkjava
	imagen -png thinkjava
	hacha thinkjava.html
	cp up.png next.png back.png html
	mv index.html thinkjava.css thinkjava*.html thinkjava*.png *motif.gif html

plastex:
	rm -rf /home/downey/book/trunk/xml/.svn
	cp book.tex xml.tex
	plastex --renderer=DocBook --theme=book --image-resolution=300 --filename=book.xml xml.tex
	rm -rf /home/downey/book/trunk/xml/.svn

xxe:
	~/Downloads/xxe-perso-4_8_0/bin/xxe xml/book.xml

epub:
	cd html; ebook-convert book.html thinkpython.epub

DISTFILES = thinkds.pdf
DIR = /home/downey/public_html/greent/thinkds

distrib:
	rm -rf thinkds
	mkdir thinkds thinkds/figs
	cp thinkds.tex latexonly htmlonly thinkds
	cp Makefile thinkds/Makefile
	cp *.png *.html thinkds
	cp figs/* thinkds/figs
	zip -r thinkds.tex.zip thinkds
	chmod 644 $(DISTFILES)
	cp $(DISTFILES) $(DIR)
	rsync -a html $(DIR)
	echo 'pushd $(DIR)/..; sh back; popd'

clean:
	rm -f *~ *.aux *.dvi *.idx *.ilg *.ind *.log *.out *.toc thinkjava.*
