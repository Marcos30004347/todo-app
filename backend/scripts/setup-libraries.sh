#!/bin/bash

for path in `ls -d ./services/*` ; do
    if [ -f $path/service.conf ]; then
        env_file="$path/service.conf";
        echo using config file $env_file; 
        if [ -d "$path/lib" ]; then rm -Rf $path/lib; fi; 
        mkdir $path/lib; 
        
        while IFS= read -r line || [[ -n "$line" ]]; do
            IFS== read -r left right <<< "$line";
            
            if [[ $left == required_libraries ]]; then 
                echo $right | tr \, \\n | while read lang ; do
                    if [ -d "$path/lib" ]; then 
                        cp -a ./lib/$lang/. $path/lib/$lang;
                    fi; 
                done; 
            fi;


        done < $env_file;
    else 
        echo "No service.conf found in $path"
    fi; 
done