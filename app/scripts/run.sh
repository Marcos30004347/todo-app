#!/bin/bash

if [$ENVIROMENT == production ] then
  echo "Starting production server(nginx)"
  /usr/sbin/nginx -g daemon off;
else
  echo "Starting development server(ember server)"
  ember serve
fi;
