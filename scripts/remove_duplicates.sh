#! /usr/bin/env bash

#=============================================
# Script Name: remove_duplicates.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-18
#       Usage: bash remove_duplicates.sh
# Description: 
#=============================================

# Define variables -- BEGIN #
# Define variables -- END #

# Script Body -- BEGIN #

ls -lS --time-style=long-iso | awk 'BEGIN{
    getline;getline;
    name1=$8;size=$5
}
{
    name2=$8
    if (size==$5){
        "md5sum $name1" | getline; csum1=$1;
        "md5sum $name2" | getline; csum2=$1;
        if ( csum1==csum2 ){
            print name1;print name2
        }
    };
    size=$5; name1=name2
}' | sort -u > duplicate_files

cat duplicate_files | xargs -I {} md5sum {} | sort | uniq -w 32 | awk '{print "^"$2"$"}' | sort -u > duplicate_sample

echo 'Removeing...'
comm duplicate_files duplicate_sample -2 -3 | tee /dev/stderr | xargs rm 
echo 'Removed duplicate files successfully'

# Script Body -- END #