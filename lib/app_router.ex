defmodule AppRouter do
  use Plug.Router 

  plug :match 
  plug :dispatch


  get "/echo" do    
    conn = fetch_query_params(conn)

    conn
    |> send_resp(200, "received #{inspect(conn.params)}")
  end 

  match _ do
    conn 
    |> send_resp(404, "not found")
  end
end 
