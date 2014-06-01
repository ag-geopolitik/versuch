
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
    hyphenation.tex \
    literatur.bib \
    tool.pl \
    versuch.tex

INCLUDES=\
    arbeitundleben.tex \
    fragen.tex \
    heute.tex \
    identity.tex \
    industriegesellschaft.tex \
    kapitalismus.tex \
    methoden.tex \
    org.tex \
    staaten.tex \
    uno.tex \
    utopien.tex \
    wirtschaftslehre.tex
.SUFFIXES: .txt

.txt.tex:
	$(FILTER) $< > $@

versuch.pdf: $(STATIC) $(INCLUDES) 
	$(LATEX) versuch.tex
	bibtex versuch
	$(LATEX) versuch.tex
	$(LATEX) versuch.tex
	dvipdf versuch.dvi

ALL: versuch.pdf

clean:
	rm -f *.aux *.bbl *.blg
	rm -f *.log
	rm -f *.dvi
	rm -f $(INCLUDES)
	rm -f *flymake.pl

distclean: clean
	rm -f versuch.pdf

view: ALL
	$(PDFVIEWER) versuch.pdf &

