
PHONY=clean,distclean,view
LATEX=latex -halt-on-error
FILTER=perl tool.pl

ifneq (,$(wildcard /usr/bin/atril))
	PDFVIEWER=atril
endif
ifneq (,$(wildcard /usr/bin/evince))
	PDFVIEWER=evince
endif

STATIC=\
    anarchie.tex \
    hyphenation.tex \
    literatur.bib \
    versuch.tex \
    tool.pl

INCLUDES=\
    arbeitundleben.tex \
    entwicklung.tex \
    fragen.tex \
    heute.tex \
    identity.tex \
    innovation.tex \
    industriegesellschaft.tex \
    institutionen.tex \
    kapitalismus.tex \
    konzept.tex \
    methoden.tex \
    org.tex \
    praktik.tex \
    staaten.tex \
    uno.tex \
    utopien.tex \
    wirtschaftslehre.tex

ANARCHY=\
    armut.tex \
    formen.tex \
    lebenswert.tex \
    markt.tex \
    poem.tex \
    revolte.tex

.SUFFIXES: .txt

.txt.tex:
	$(FILTER) $< > $@

versuch.pdf: versuch.tex $(STATIC) $(INCLUDES) 
	$(LATEX) versuch.tex
	bibtex versuch
	$(LATEX) versuch.tex
	$(LATEX) versuch.tex
	dvipdf versuch.dvi

markt-und-anarchie.pdf: anarchie.tex $(STATIC) $(ANARCHY)
	$(LATEX) anarchie.tex
	bibtex anarchie
	$(LATEX) anarchie.tex
	$(LATEX) anarchie.tex
	dvipdf -sOutputFile=markt-und-anarchie.pdf anarchie.dvi

ALL: versuch.pdf markt-und-anarchie.pdf

clean:
	rm -f *.aux *.bbl *.blg
	rm -f *.log
	rm -f *.dvi
	rm -f $(INCLUDES)
	rm -f $(ANARCHY)
	rm -f *flymake.pl

distclean: clean
	rm -f versuch.pdf
	rm -f markt-und-anarchie.pdf

anarchy: markt-und-anarchie.pdf
	$(PDFVIEWER) markt-und-anarchie.pdf &

view: versuch.pdf
	$(PDFVIEWER) versuch.pdf &

