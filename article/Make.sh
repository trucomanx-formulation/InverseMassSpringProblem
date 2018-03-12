#!/bin/bash

latex  -interaction=nonstopmode  article_1.tex
bibtex article_1
latex  -interaction=nonstopmode  article_1.tex
latex  -interaction=nonstopmode  article_1.tex

dvips -o article_1.ps article_1.dvi
ps2pdf article_1.ps article_1.pdf
./Clean.sh
