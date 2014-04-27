
PHONY=all,clean,distclean,view,INCLUDES
LATEX=latex -halt-on-error
FILTER=perl tool.pl

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

versuch.pdf: versuch.tex literatur.bib $(INCLUDES)
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
	atril versuch.pdf &

