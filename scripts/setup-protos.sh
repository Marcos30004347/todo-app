for path in `ls -d ./services/*`; do
    if [ $path == "./services/api" ]; then continue; fi;

    echo "Copying ./protos/ directory inside $path";

    if [ -d "$path/protos" ]; then rm -Rf $path/protos; fi;
    mkdir $path/protos;
    cp -a ./protos/. $path/protos;
done