defmodule WeftfeedWeb.PageController do
  use WeftfeedWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
