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

  def process(icao_code) do
    WeatherConditions.ICAO.fetch(icao_code)
  end
end
