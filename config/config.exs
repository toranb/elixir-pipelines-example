# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :pipelinez, PipelinezWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "u/Bd/E/+k6xtfbXtYfUwk5weVyoN6CqPY8cXlzK94ymkkjUDV0ggotgAUYqKyH5O",
  render_errors: [view: PipelinezWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pipelinez.PubSub,
  live_view: [signing_salt: "McQA1pIP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
