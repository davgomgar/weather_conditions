defmodule WeatherConditions.ICAO do

  import HTTPoison

  @url_prefix "http://w1.weather.gov/xml/current_obs/"

  def fetch(icao_code) do
    icao_code
    |> generate_url
    |> fetch_weather_info
  end

  def generate_url(icao_code) do
    @url_prefix <> String.upcase(icao_code) <> ".xml"
  end

  def fetch_weather_info(url) do
    case HTTPoison.get url do
      {:ok, %{status_code: 200, body: body}} -> body
      {:ok, %{status_code: 404}} -> raise ArgumentError, "Not found :(  Check URL"
      {_, %{reason: reason}} -> IO.puts reason
    end
  end
end
