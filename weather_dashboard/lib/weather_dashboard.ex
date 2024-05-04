defmodule WeatherDashboard do
  def fetch_weather(city, state_or_country) do
    base_url = "https://api.openweathermap.org/data/2.5/weather"
    api_key = "Enter API Key"

    location = URI.encode("#{city}, #{state_or_country}, US")
    url = "#{base_url}?q=#{location}&appid=#{api_key}&units=imperial"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Jason.decode() |> handle_response()

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} when status_code in 400..599 ->
        IO.puts("HTTP Error #{status_code}: #{body}")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Failed to fetch weather data: #{reason}")
    end
  end

  defp handle_response({:ok, data}) do
    main = data["main"]
    weather = data["weather"]
    city = data["name"]

    IO.puts("Weather in #{city}:")
    IO.puts("Temperature: #{main["temp"]}°F")
    IO.puts("Humidity: #{main["humidity"]}%")
    IO.puts("Conditions: #{Enum.at(weather, 0)["description"]}")
  end
end
