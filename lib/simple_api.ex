defmodule SimpleApi do
  use Application 
  require Logger

  def start(_type, _args) do 
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, AppRouter, [], [port: 4001]),
      supervisor(SimpleApi.Repo, [])
    ]

    Logger.info "starting application"
    
    opts = [strategy: :one_for_one, name: SimpleApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
