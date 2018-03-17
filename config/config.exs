# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

#imoprt_config
# import_config "env.local.exs"
# General application configuration
config :friendly,
  ecto_repos: [Friendly.Repo]

# Configures the endpoint
config :friendly, FriendlyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FqpGSGqOiKp8LedhpJnc4FaOxtoNzRdbOBdQSmvokNl0ZUA+ycrTVkcdufuBhoys",
  render_errors: [view: FriendlyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Friendly.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

## Configure Uberauth for Auth0
config :ueberauth, Ueberauth,
  providers: [
    auth0: { Ueberauth.Strategy.Auth0, [] },
  ]
config :ueberauth, Ueberauth.Strategy.Auth0.OAuth,
  domain: System.get_env("AUTH0_DOMAIN"),
  client_id: System.get_env("AUTH0_CLIENT_ID"),
  client_secret: System.get_env("AUTH0_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
