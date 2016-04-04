defmodule ElmPhoenixed.PageController do
  use ElmPhoenixed.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def gather_args(nil) do [] end
  def gather_args(action) do gather_args(action, 0) end
  def gather_args(action, index) do
    current_index = "_" <> (to_string index)
    value = Map.get(action, current_index)

    if value == nil do
      []
    else
      [ value ] ++ gather_args(action, index + 1)
    end
  end

  @spec run_action(char_list, list, number) :: number
  def run_action("Sub", args, model) do model - Enum.sum(args) end
  def run_action("Add", args, model) do model + Enum.sum(args) end
  def run_action("RecordAdd", [], model) do model end
  def run_action("RecordAdd", [ head | tail ], model) do
    add = Map.get(head, "add", 0)
    model + add
  end
  def run_action(_, _, model) do model end

  def api(conn, params) do
    action = Map.get(params, "action")
    args = gather_args(action)
    model = Map.get(params, "model")

    action_name = Map.get(action, "ctor")

    json conn, %{model: run_action(action_name, args, model)}
  end
end
