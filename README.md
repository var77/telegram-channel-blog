# Telegram Channel Blog


### To Run

> Create Telegram channel

> Create telegram bot

> Add bot as admin to your channel


> __You need to have installed [Elixir](https://elixir-lang.org/install.html), [Postgres](https://www.postgresql.org/download/) and [NodeJS](https://nodejs.org/en/download/package-manager/)__

```
mix deps.get
mix blog.compile # (if you want frontend)
mix phx.server
```
> Add env vars based on `config/config.exs` file

> Create database defined in `config.ex` and run migrations with `cd ./apps/channel_repo && mix ecto.migrate -r Repo`

> Then go to http://localhost:4000 and post something to your channel

> You can build your own client using API mentioned below

## API

-  **GET** - **/blog/posts?skip=0&limit=0**

    **response** - ```[{
                id: String,
                video: null | String,
                photo: null | String,
                title: String,
                text: String,
                date: Number(ms),
                channel: String
            }]```

-  **GET** - **/blog/post/:id**

    **response** - ```{
                id: String,
                video: null | String,
                photo: null | String,
                title: String,
                text: String,
                date: Number(ms),
                channel: String
            }``` or 404
