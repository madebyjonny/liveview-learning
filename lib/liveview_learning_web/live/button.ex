defmodule LiveviewLearningWeb.ButtonLive do
  use LiveviewLearningWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, count: 10)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Button</h1>
    <span>count: <%= @count %></span>
    <br />
    <button phx-click="increment">Increment</button>
    """
  end

  def handle_event("increment", _unsigned_params, socket) do
    socket = update(socket, :count, &(&1 + 10))
    {:noreply, socket}
  end
end
