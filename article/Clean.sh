#!/bin/bash

rm -f *.aux
rm -f *.dvi
rm -f *.log  
rm -f *.out
rm -f *.blg
rm -f *.bbl 
rm -f *.spl
rm -f *.backup 
rm -f *.ps

find . -type f -name "*.pdf" -not -name 'article_1.pdf'  -not -name 'Cover_Letter.pdf'| xargs rm

