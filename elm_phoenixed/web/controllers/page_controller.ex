defmodule ElmPhoenixed.PageController do
  use ElmPhoenixed.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
