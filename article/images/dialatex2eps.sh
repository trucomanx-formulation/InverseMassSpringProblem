#!/bin/bash


FILENAME=( "system-mass-spring" "system-mass-spring-2" "system-mass-spring-model1" "system-mass-spring-model2")

for i in ${FILENAME[@]}; 
do  
    echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    echo $i
    echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    dia $i.dia -t mp --export=$i.mp

    sed -i '/\documentclass{minimal}/a \
    \\usepackage{amsmath,amssymb}' $i.mp

    mpost  -tex=latex -interaction=nonstopmode $i.mp

    echo "\documentclass{article}
    \pagestyle{empty}
    \usepackage{graphicx}
    \begin{document}
    \includegraphics[width=\textwidth]{"$i.1"}
    \end{document}" > temporallatex-$i.tex


    latex temporallatex-$i.tex
    dvips -E -o $i.eps temporallatex-$i

    rm -f $i.log
    rm -f $i.mpx
    rm -f $i.mp
    rm -f $i.1

    rm -f temporallatex-$i.tex
    rm -f temporallatex-$i.aux  
    rm -f temporallatex-$i.log  
    rm -f temporallatex-$i.dvi

    #convert -density 400 $i.eps -flatten $i.png

    #rm -f $i.eps

done
