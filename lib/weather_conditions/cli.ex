defmodule WeatherConditions.CLI do

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse do
      {[help: true], _, _} -> :help
      {_,[icao_code], _} -> icao_code
       _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    Usage: weather_conditions <icao_code>
    """
  end

  def process(icao_code) do
    WeatherConditions.ICAO.fetch(icao_code)
    |> display_information(icao_code) 
  end

  def display_information(kwords, icao_code) do
    IO.puts "CURRENT WEATHER INFORMATION FOR #{String.upcase(icao_code)}"
    IO.puts "======================================"
    IO.puts "Time: #{Keyword.get(kwords, :time)}"
    IO.puts "Weather: #{Keyword.get(kwords, :weather)}"
    IO.puts "Temperature: #{Keyword.get(kwords, :temperature)}"
    IO.puts "Pressure: #{Keyword.get(kwords, :pressure)}"
    IO.puts "Humidity: #{Keyword.get(kwords, :humidity)}"
    IO.puts "Dewpoint: #{Keyword.get(kwords, :dewpoint)}"
    IO.puts "Longitude: #{Keyword.get(kwords, :longitude)}"
    IO.puts "Latitude: #{Keyword.get(kwords, :latitude)}"
    IO.puts "Location: #{Keyword.get(kwords, :location)}"
    IO.puts "Visibility: #{Keyword.get(kwords, :visibility)}"
  end
end
