for path in `ls -d ./services/*`; do
    if [ -d "$$path/protos" ]; then rm -Rf $$path/protos; fi;
    mkdir $$path/protos;
    cp -a ./protos/. $$path/protos;
done