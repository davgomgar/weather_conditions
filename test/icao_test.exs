defmodule WeatherConditions.ICAO.Test do

  use ExUnit.Case

  import WeatherConditions.ICAO
  alias WeatherConditions.ICAO, as: ICAO

  test "returns well formatted url for icao codes" do
    ~w{KBDD kjFK kjfx kJHN}
    |> Enum.each(fn code -> assert ICAO.generate_url(code) == "http://w1.weather.gov/xml/current_obs/" <> String.upcase(code) <> ".xml" end)
  end
end
