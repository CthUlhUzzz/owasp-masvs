#!/bin/bash
# Script taken and adapted from https://github.com/OWASP/CheatSheetSeries/blob/master/scripts/Apply_Link_Check.sh
# Script in charge of auditing the released MD files in order to detect dead links


apply_link_check_lang() {
    echo "Checking links for language $1"
    if test -f "../link-check-result-$1.out"; then
        rm ../link-check-result-$1.out
    fi
    cd ../Document-$1
    find . -name \*.md -exec markdown-link-check -q -c ../.markdownlinkcheck.json {} \; 1>../link-check-result-$1.out 2>&1

    errors=`grep -c "ERROR:" ../link-check-result-$1.out`
    content=`cat ../link-check-result-$1.out`
    if [[ $errors != "0" ]]
    then
        echo "[!] Error(s) found by the Links validator for $1: $errors pages have dead links! Verbose output in /link-check-result-$1.out"
        echo "Only warning for now..."
    else
        echo "[+] No error found by the Links validator for $1."
        rm ../link-check-result-$1.out
    fi
}

apply_link_check_en() {
    echo "Checking links for language EN"
    if test -f "../link-check-result.out"; then
        rm ../link-check-result.out
    fi
    cd ../Document
    find . -name \*.md -exec markdown-link-check -q -c ../.markdownlinkcheck.json {} \; 1>../link-check-result.out 2>&1
    errors=`grep -c "ERROR:" ../link-check-result.out`
    content=`cat ../link-check-result.out`
    if [[ $errors != "0" ]]
    then
        echo "[!] Error(s) found by the Links validator for EN: $errors pages have dead links! Verbose output in /link-check-result.out"
        echo "Only warning for now..."
    else
        echo "[+] No error found by the Links validator for EN."
        rm ../link-check-result.out
    fi
}

apply_link_check_en
apply_link_check_lang de
apply_link_check_lang es
apply_link_check_lang fr
apply_link_check_lang ja
apply_link_check_lang ru
apply_link_check_lang zhtw