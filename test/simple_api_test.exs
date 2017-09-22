defmodule SimpleApiTest do
  use ExUnit.Case
  use Plug.Test  

  @opts AppRouter.init([])

  test "echo" do
    conn = conn(:get, "/echo", "")
          |> AppRouter.call(@opts) 

    assert conn.state == :sent 
    assert conn.status == 200
  end
end
