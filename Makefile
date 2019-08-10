HTMLTEX       = htlatex
CUSTOMCSS     = style.css
AUXFILES      = $(wildcard *.aux *.tmp *.toc *.xref *.lg *.idv *.dvi *.4tc *.4ct *.out *.log)
SOURCES       = $(wildcard *.tex)
HTML          = $(SOURCES:.tex=.html)
HTMLTEX_FLAGS = "style, html, charset=utf-8"

.PHONY: rmaux html clean all

all: html

html: $(SOURCES) $(HTML)

clean: rmaux
	rm -f $(HTML)

rmaux:
	rm -f $(AUXFILES)

%.html: %.tex $(CUSTOMCSS)
	$(HTMLTEX) $< $(HTMLTEX_FLAGS) && cat $(CUSTOMCSS) >> $(<:.tex=.css) &&\
	    sed -i '1 i\@import url(https://fonts.googleapis.com/css?family=Lato:300italic,300,400&subset=latin);' $(<:.tex=.css) &&\
	    sed -i '1 i\@import url("https://fonts.googleapis.com/css?family=Roboto+Mono");' $(<:.tex=.css) &&\
	    sed -i 's/monospace/"Roboto Mono"/g' $(<:.tex=.css) &&\
	    sed -i 's/"@myfont"/"Lato"/g' $(<:.tex=.css) &&\
	    sed -i 's/font-weight: bold/font-weight: 400/g' $(<:.tex=.css) &&\
	    sed -i 's/font-weight: normal/font-weight: 300/g' $(<:.tex=.css) &&\
	    make rmaux
		







