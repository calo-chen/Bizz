defmodule Bizz.Repo do
  use Ecto.Repo,
    otp_app: :bizz,
    adapter: Ecto.Adapters.Postgres
end
