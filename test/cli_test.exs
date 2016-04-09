defmodule WeatherConditions.CLI.Test do
  use ExUnit.Case

  import WeatherConditions.CLI

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "returns received ICAO code " do
    assert parse_args(["KACY"]) == "KACY"
    assert parse_args(["KDLZ"]) == "KDLZ"
  end

end
