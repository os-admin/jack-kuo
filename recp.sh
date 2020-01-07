#! /bin/sh

if [ $# -eq 0 ]; then
    echo "pls add file"
    exit 1
fi

OS=$(uname -s)
case $OS in
Linux)
    cp="xclip -sel clip"
    ;;
Darwin)
    cp="pbcopy"
    ;;
*)
    echo"not support"
    exit 1
    ;;
esac

count=0
for fn in $@; do
    case $fn in
    *.sh | *.py)
        comment="# $fn"
        ;;
    *.sql)
        comment="--- $fn"
        ;;
    *.html | *.htm)
        comment="<!-- $fn -->"
        ;;
    *)
        comment="// $fn"
        ;;
    esac

    echo $comment
    cat $fn
    ((count++))
    if [ $count -ne $# ]; then
        echo
    fi
done | $cp
