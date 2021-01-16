#!/bin/bash
# https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html
# https://roll.urown.net/ca/ca_root_setup.html
# https://stackoverflow.com/questions/37714558/how-to-enable-server-side-ssl-for-grpc

PASS=1234
CONFIG_FILE=ssl.conf
SUBJECT_CA="/C=US/ST=CA/L=Cupertino/O=YourCompany/OU=YourApp/CN=MyRootCA"
SUBJECT_SERV="/C=US/ST=CA/L=Cupertino/O=YourCompany/OU=YourApp/CN=%COMPUTERNAME%"
SUBJECT_CLI="/C=US/ST=CA/L=Cupertino/O=YourCompany/OU=YourApp/CN=%CLIENT-COMPUTERNAME%"

while getopts p:c:signca:signserv:signcli: flag
do
    case "${flag}" in
        p) PASS=${OPTARG};;
        c) CONFIG_FILE=${OPTARG};;
        subjca) SUBJECT_CA=${OPTARG};;
        subjserv) SUBJECT_SERV=${OPTARG};;
        subjcli) SUBJECT_CLI=${OPTARG};;
    esac
done

if [ -d "./certs" ]; then rm -Rf ./certs; fi
mkdir certs

echo Generate CA key:
openssl genrsa -passout pass:$PASS -des3 -out certs/ca.key 4096

echo Generate CA certificate:
openssl req -passin pass:$PASS -new -x509 -days 365 -key certs/ca.key -out certs/ca.crt -subj $SUBJECT_CA -config $CONFIG_FILE

echo Generate server key:
openssl genrsa -passout pass:$PASS -des3 -out certs/server.key 4096

echo Generate server signing request:
openssl req -passin pass:$PASS -new -key certs/server.key -out certs/server.csr -subj $SUBJECT_SERV -config $CONFIG_FILE

echo Self-sign server certificate:
openssl x509 -req -passin pass:$PASS -days 365 -in certs/server.csr -CA certs/ca.crt -CAkey certs/ca.key -set_serial 01 -out certs/server.crt

echo Remove passphrase from server key:
openssl rsa -passin pass:$PASS -in certs/server.key -out certs/server.key

echo Generate client key
openssl genrsa -passout pass:$PASS -des3 -out certs/client.key 4096

echo Generate client signing request:
openssl req -passin pass:$PASS -new -key certs/client.key -out certs/client.csr -subj $SUBJECT_CLI -config $CONFIG_FILE

echo Self-sign client certificate:
openssl x509 -passin pass:$PASS -req -days 365 -in certs/client.csr -CA ca.crt -CAkey certs/ca.key -set_serial 01 -out certs/client.crt -config $CONFIG_FILE

echo Remove passphrase from client key:
openssl rsa -passin pass:$PASS -in certs/client.key -out certs/client.key