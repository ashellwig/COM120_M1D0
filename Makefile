RM=rm -rf
LATEXMK=latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make
MAKE4HT=make4ht \
		main.tex \
		",charset=utf-8" "-cunihtf -utf8" \
		"" \
		"-interaction=nonstopmode"
BIB_FILE=main

# Build Commands
.PHONY: Main.pdf Main.html all clean
all: Main.pdf Main.html viewpdf viewhtml clean
clean-all: clean all-clean
pdf: Main.pdf viewpdf clean
html: Main.html viewhtml clean

# Building
Main.pdf: main.tex
	$(LATEXMK) $<
	# biber $(BIB_FILE)
	$(LATEXMK) $<
	$(LATEXMK) $<

Main.html: main.tex
	$(MAKE4HT)
	# biber $(BIB_FILE)
	$(MAKE4HT)
	$(MAKE4HT)

# Viewing
viewpdf: Main.pdf
	/usr/bin/google-chrome-stable ./main.pdf

viewhtml: Main.html
	/usr/bin/google-chrome-stable ./main.html

# Cleaning
clean:
	latexmk -c
	$(RM) *.4tc
	$(RM) *.4ct
	$(RM) *.tmp
	$(RM) *.xref
	$(RM) *.idv
	$(RM) *.lg
	$(RM) *.lol
	$(RM) *.bbl
	$(RM) *.bib.bbl
	$(RM) *.bib.blg
	$(RM) *.run.xml
	$(RM) *.bbl
	$(RM) *.bib.bbl
	$(RM) *.bib.blg
	$(RM) *.run.xml
	$(RM) *.synctex.gz
	$(RM) *.dvi
	$(RM) *.out.ps

all-clean: clean
	$(RM) *.html
	$(RM) *.css
	$(RM) *.pdf
