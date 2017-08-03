# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :secret_grinch,
  ecto_repos: [SecretGrinch.Repo]

# Configures the endpoint
config :secret_grinch, SecretGrinchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PAXlt7j3dZ+5xdanZods6i3BoNRjyEnX2T7vGZOBNKOko8pTM33UWGYYBqGxoc+M",
  render_errors: [view: SecretGrinchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SecretGrinch.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
