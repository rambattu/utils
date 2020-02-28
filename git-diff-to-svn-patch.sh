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

# Slight modification of the gist here https://gist.github.com/katta/1028871,
# that script works with the diff that got generated from git using --no-prefix,
# this script git-diff-to-svn-patch.sh can be used to work on diff that is generated
# without "--no-prefix" option as well
