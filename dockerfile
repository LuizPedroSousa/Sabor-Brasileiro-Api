FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client


WORKDIR /usr/app

COPY . .


RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix do compile

EXPOSE 4000
CMD ["./entrypoint.sh"]
