# WeatherConditions

**Fetch weather conditions for any existing US Aerodrome using its unique ICAO code

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add weather_conditions to your list of dependencies in `mix.exs`:

        def deps do
          [{:weather_conditions, "~> 0.0.1"}]
        end

  2. Ensure weather_conditions is started before your application:

        def application do
          [applications: [:weather_conditions]]
        end

