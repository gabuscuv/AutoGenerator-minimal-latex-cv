#!/bin/sh

NAME="BustilloDelCuvilloGabriel"

NAMEFILE="minimal-latex-cv";
LANGS=${CUSTOMLANG:-"en es"};
JOBTYPES=${JOBTYPE:-"dev gamedev backend webdev embeddedsystem"};
NOCUTPAGES=${NOCUTPAGES:-0}

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
        if [ "$NOCUTPAGES" -eq 1 ];then
            mv $NAMEFILE.pdf $PWD/output/`getResumeLocalized $LANG`-$NAME-$LANG-$JOBTYPE.pdf
        else
            qpdf $NAMEFILE.pdf --pages . 1 -- $PWD/output/`getResumeLocalized $LANG`-$NAME-$LANG-$JOBTYPE.pdf
        fi
        
    done
done

rm *.aux *.log *.out *.gz

#cp output/* $HOME/git/misc/gabuscuv-misc/resume/
