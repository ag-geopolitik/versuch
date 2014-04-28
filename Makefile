
PHONY=all,clean,distclean,view,tool.pl
LATEX=latex -halt-on-error
FILTER=perl tool.pl

ifneq (,$(wildcard /usr/bin/atril))
	PDFVIEWER=atril
endif
ifneq (,$(wildcard /usr/bin/evince))
	PDFVIEWER=evince
endif

INCLUDES=\
    arbeitundleben.tex \
    fragen.tex \
    identity.tex \
    industriegesellschaft.tex \
    kapitalismus.tex \
    methoden.tex \
    org.tex \
    utopien.tex \
    wirtschaftslehre.tex
.SUFFIXES: .txt

.txt.tex:
	$(FILTER) $< > $@

versuch.pdf: versuch.tex literatur.bib $(INCLUDES) tool.pl 
	$(LATEX) versuch.tex
	bibtex versuch
	$(LATEX) versuch.tex
	$(LATEX) versuch.tex
	dvipdf versuch.dvi

all: versuch.pdf
clean:
	rm -f *.aux *.bbl *.blg
	rm -f *.log
	rm -f *.dvi
	rm -f $(INCLUDES)
	rm -f *flymake.pl

distclean: clean
	rm -f versuch.pdf

view: all
	$(PDFVIEWER) versuch.pdf &

