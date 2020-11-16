FROM elixir:1.11.2-alpine

WORKDIR /usr/src/app

COPY . .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix compile

CMD cd ./apps/channel_repo && mix ecto.migrate -r Repo && cd ../../ && mix phx.server