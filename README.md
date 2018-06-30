# Telegram Channel Blog


### To Run

> Create Telegram channel

> Create telegram bot

> Add bot as admin to your channel

> Edit `config/config.exs` file to add your bot token

```
mix deps.get
mix blog.compile
mix phx.server
```
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
