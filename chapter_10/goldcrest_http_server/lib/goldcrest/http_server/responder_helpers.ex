defmodule Goldcrest.HTTPServer.ResponderHelpers do
  def http_response(body) do
    %Goldcrest.HTTPResponse{body: body}
  end

  def put_header(%{headers: headers} = resp, key, value) do
    headers = Map.merge(headers, %{String.downcase(key) => value})
    %{resp | headers: headers}
  end

  def put_status(resp, status) do
    %{resp | status: status}
  end
end
