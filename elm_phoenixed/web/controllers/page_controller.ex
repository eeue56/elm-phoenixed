defmodule ElmPhoenixed.PageController do
  use ElmPhoenixed.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def run_action("Sub", model, n) do model - n end
  def run_action("Add", model, n) do model + n end
  def run_action("AddTwo", model, n, m) do n + m end
  def run_action("RecordAdd", model, record) do
    add = Map.get(record, "add", 0)
    model + add
  end
  def run_action(_, model, _) do model end

  def api(conn, params) do
    action = Map.get(params, "action")
    args = Elmxir.gather_args(action)
    model = Map.get(params, "model")

    action_name = Elmxir.get_action_name(action)

    full_arguments = [ action_name, model ] ++ args

    json conn, %{model: apply(ElmPhoenixed.PageController, :run_action, full_arguments)}
  end
end
