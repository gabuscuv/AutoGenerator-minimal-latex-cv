#!/bin/sh

NAME="BustilloDelCuvilloGabriel"

NAMEFILE="minimal-latex-cv";
LANGS="es en";
JOBTYPES="dev gamedev";

getResumeLocalized()
{

case $1 in
    "en")
        echo "resume"
        ;;
    "es")
        echo "cv"
        ;;
esac
echo "";
}

if [ ! -d $PWD/output ];then
mkdir $PWD/output
fi

for JOBTYPE in $JOBTYPES
do
    for LANG in $LANGS
    do
        pdflatex -synctex=1 -interaction=nonstopmode '\def \langsa {'$LANG'} \def \jobtype {'$JOBTYPE'} \input{'$NAMEFILE'.tex}'
        mv $NAMEFILE.pdf $PWD/output/`getResumeLocalized $LANG`-$NAME-$LANG-$JOBTYPE.pdf
    done
done

rm *.aux *.log *.out *.gz

## For some reason, It's generating a white page just in one kind of resume
qpdf output/cv-BustilloDelCuvilloGabriel-es-gamedev.pdf --pages . 1 -- cv-BustilloDelCuvilloGabriel-es-gamedev.pdf
mv ./cv-BustilloDelCuvilloGabriel-es-gamedev.pdf output/cv-BustilloDelCuvilloGabriel-es-gamedev.pdf