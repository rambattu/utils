#!/bin/sh
# Given a diff file generated in a git repo, this script converts it
# to SVN patch file.
if [[ $# -ne 1 ]] ; then
    me=`basename "$0"`
    echo "Usage: $me git-files.diff"
    exit 1
fi
filename=`basename -s .diff $1`
out_filename=${filename}-svn.patch
echo "Writing SVN patch output to $out_filename"
cat $1 | sed -e "s/^diff --git [^[:space:]]*/Index:/" -e "s/^index.*/===================================================================/" -e "s/^Index: b\//Index: /" -e "s/^--- a\//--- /" -e "s/^+++ b\//+++ /" > $out_filename    
