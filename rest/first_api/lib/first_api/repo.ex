defmodule FirstApi.Repo do
  use Ecto.Repo,
    otp_app: :first_api,
    adapter: Ecto.Adapters.Postgres
end
