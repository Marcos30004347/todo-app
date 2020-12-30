FROM ruby

WORKDIR /
COPY . .

RUN apt-get install make && make

EXPOSE 80

CMD ["./scripts/entrypoint.sh"]