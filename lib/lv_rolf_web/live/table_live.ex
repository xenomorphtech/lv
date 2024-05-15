# lib/my_app_web/live/table_live.ex
defmodule LvRolfWeb.TableLive do
  use LvRolfWeb, :live_view

  def mount(_params, _session, socket) do
    data = [
      %{id: 1, name: "John", age: 25},
      %{id: 2, name: "Jane", age: 30},
      %{id: 3, name: "Bob", age: 35}
    ]

    {:ok, assign(socket, data: data)}
  end

  def render(assigns) do
    ~H"""
    <h1>User Table</h1>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Age</th>
        </tr>
      </thead>
      <tbody>
        <%= for user <- @data do %>
          <tr>
            <td><%= user.id %></td>
            <td><%= user.name %></td>
            <td><%= user.age %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end
end

defmodule LvRolfWeb.TableLive2 do
  use LvRolfWeb, :live_view

  def render(assigns) do
    ~L"""
    <div>
      <span id="sentence" phx-hook="SentenceHook"><%= raw(@colored_sentence) %></span>
      
      <div class="images">
        <img src="image1.jpg" alt="Image 1" phx-click="start_dragging" phx-value-index="0">
        <img src="image2.jpg" alt="Image 2" phx-click="start_dragging" phx-value-index="1">
        <img src="image3.jpg" alt="Image 3" phx-click="start_dragging" phx-value-index="2">
        <img src="image4.jpg" alt="Image 4" phx-click="start_dragging" phx-value-index="3">
        <img src="image5.jpg" alt="Image 5" phx-click="start_dragging" phx-value-index="4">
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    sentence = "<noun>Кошка</noun> <adverb>быстро</adverb> <verb>прыгнула</verb> на <adjective>высокий</adjective> <noun>забор</noun>."
    colored_sentence = color_sentence(sentence)

    {:ok, assign(socket, colored_sentence: colored_sentence, dragged_image: nil)}
  end

  def handle_event("start_dragging", %{"index" => index}, socket) do
    {:noreply, assign(socket, dragged_image: String.to_integer(index))}
  end

  defp color_sentence(sentence) do
    sentence
    |> String.replace(~r/<noun>/, "<span class=\"noun\">")
    |> String.replace(~r/<\/noun>/, "</span>")
    |> String.replace(~r/<adverb>/, "<span class=\"adverb\">")
    |> String.replace(~r/<\/adverb>/, "</span>")
    |> String.replace(~r/<verb>/, "<span class=\"verb\">")
    |> String.replace(~r/<\/verb>/, "</span>")
    |> String.replace(~r/<adjective>/, "<span class=\"adjective\">")
    |> String.replace(~r/<\/adjective>/, "</span>")
  end
end
