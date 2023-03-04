defmodule Goldcrest.ExampleController do
  import Plug.Conn
  import Goldcrest.Controller

  def call(conn, action: action) do
    apply(__MODULE__, action, [conn, conn.params])
  end

  def greet(conn, _params) do
    conn
    |> put_status(200)
    |> render(:json, %{status: "ok"})
  end

  def redirect_greet(conn, params) do
    case validate_params(params) do
      :ok ->
        conn
        |> redirect(to: "/greet")

      other ->
        other
    end
  end

  defp validate_params(%{"greet" => "true"}), do: :ok
  defp validate_params(_), do: {:error, :bad_params}
end
