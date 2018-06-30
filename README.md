# Telegram Channel Blog


### To Run

> Create Telegram channel

> Create telegram bot

> Add bot as admin to your channel

> Edit `config.exs` file to add your bot token

```
mix deps.get
mix phx.server
cd priv/client && npm i && npm start
```
> Then go to http://localhost:3000 and post something to your channel

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
