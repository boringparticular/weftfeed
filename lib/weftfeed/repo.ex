defmodule Weftfeed.Repo do
  use Ecto.Repo,
    otp_app: :weftfeed,
    adapter: Ecto.Adapters.Postgres
end
