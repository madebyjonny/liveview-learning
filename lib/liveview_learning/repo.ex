defmodule LiveviewLearning.Repo do
  use Ecto.Repo,
    otp_app: :liveview_learning,
    adapter: Ecto.Adapters.Postgres
end
