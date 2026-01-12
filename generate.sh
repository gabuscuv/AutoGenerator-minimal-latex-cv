#!/bin/sh

NAME="BustilloDelCuvilloGabriel"

NAMEFILE="minimal-latex-cv";
LANGS="es en";
JOBTYPES="dev gamedev backend webdev";

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
        qpdf $NAMEFILE.pdf --pages . 1 -- $PWD/output/`getResumeLocalized $LANG`-$NAME-$LANG-$JOBTYPE.pdf
    done
done

rm *.aux *.log *.out *.gz

#cp output/* $HOME/git/misc/gabuscuv-misc/resume/
