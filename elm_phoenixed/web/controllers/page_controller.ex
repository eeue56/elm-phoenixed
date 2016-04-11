defmodule ElmPhoenixed.PageController do
  use ElmPhoenixed.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def gather_args(nil) do [] end
  def gather_args(action) do gather_args(action, 0) end
  def gather_args(action, index) do
    current_index = "_#{index}"
    value = Map.get(action, current_index)

    if value == nil do
      [ ]
    else
      [ value | gather_args(action, index + 1) ]
    end
  end

  @spec run_action(char_list, list, number) :: number
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
    args = gather_args(action)
    model = Map.get(params, "model")

    IO.inspect action

    action_name = Map.get(action, "ctor")

    full_arguments = [ action_name, model ] ++ args

    json conn, %{model: apply(ElmPhoenixed.PageController, :run_action, full_arguments)}
  end
end
