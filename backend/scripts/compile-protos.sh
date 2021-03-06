#!/bin/bash

for path in `ls -d ./services/*` ; do
    if [ -f $path/service.conf ]; then
        env_file="$path/service.conf";

        while IFS= read -r line || [[ -n "$line" ]]; do\
            IFS== read -r left right <<< "$line";
            if [[ $left == required_libraries ]]; then
                echo $right | tr \, \\n | while read lang ; do
                    for filename in $path/protos/*.proto; do
                        cd $path
                        make compile-protos
                        cd ..
                    done;
                done;
            fi;
        done < $env_file;
    else
        echo "No service.conf file in $path";
    fi;
done