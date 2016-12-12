#!/bin/bash

reA="\b[a|A][A-Z|a-z]*\b"
reD="\b[d|D][A-Z|a-z]*[d|D]\b"
reN="\b[0-9]+\b"
reAN="\b[a-z|A-Z|0-9]+([a-z]+[0-9]+|[0-9]+[a-z]+)[a-z|0-9]*"

linecount=0
wordcount=0
doubled=0
beginwitha=0
numeric=0
alphanumeric=0

filename=${1}
while read -r line
do
	linecount=$((linecount+1))
	words=${line}
	for word in $words
	do 
		if [[ $word =~ $reA ]]; then
			
			beginwitha=$((beginwitha+1))
		fi
		
		if [[ $word =~ $reD ]]; then
			
			doubled=$((doubled+1))
		fi
		
		if [[ $word =~ $reN ]]; then
			
			numeric=$((numeric+1))
		fi
		
		if [[ $word =~ $reAN ]]; then
			
			alphanumeric=$((alphanumeric+1))
		fi
		
		wordcount=$((wordcount+1))
	done 
done < ${filename}

echo "Line count: $linecount"
echo "Word Count: $wordcount"
echo "Words beginning with 'A': $beginwitha"
echo "Words beginning and ending with 'D': $doubled"
echo "Numeric words: $numeric"
echo "Alphanumeric words: $alphanumeric"

echo "Most frequent word:"
cat ${1} | tr 'A-Z' 'a-z' | sed 's/--/ /g' | sed 's/[^a-z ]//g' | tr -s '[[:space:]]' '\n' | sort | uniq -c | sort -n | tail -n1

echo "Least frequent word:"
cat ${1} | tr 'A-Z' 'a-z' | sed 's/--/ /g' | sed 's/[^a-z ]//g' | tr -s '[[:space:]]' '\n' | sort | uniq -c | sort -n | head -n1