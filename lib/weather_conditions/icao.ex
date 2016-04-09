defmodule WeatherConditions.ICAO do

  #Xml parser
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")


  @url_prefix Application.get_env(:weather_conditions, :service_url) 
  @xml_tags [:location, :latitude, :longitude, :time, :weather, :temperature, :pressure, :humidity, :wind, :dewpoint, :visibility]

  def fetch(icao_code) do
    icao_code
    |> generate_url
    |> fetch_weather_info
    |> process_weather_info
  end

  def generate_url(icao_code) do
    "#{@url_prefix}/#{String.upcase(icao_code)}.xml"
  end

  def fetch_weather_info(url) do
    case HTTPoison.get url do
      {:ok, %{status_code: 200, body: body}} -> body
      {:ok, %{status_code: 404}} -> raise ArgumentError, "Not found :(  Check URL"
      {_, %{reason: reason}} -> raise ArgumentError, reason
    end
  end

  def process_weather_info(info) do
    info
    |> scan_xml
    |> parse_xml
  end

  def scan_xml(xml_str) do
   :xmerl_scan.string(String.to_char_list(xml_str))
  end

  def parse_xml({xml, _}) do
    @xml_tags
    |> Enum.reduce([], fn(current, total) -> Keyword.put(total, current, fetch_tag_value(xml, current))end)
  end

  def fetch_tag_value(xml, tag) do
    case tag do
      :location -> extract_current_tag_info xml, 'location'
      :latitude -> extract_current_tag_info xml, 'latitude'
      :longitude -> extract_current_tag_info xml, 'longitude'
      :time -> extract_current_tag_info xml, 'observation_time'
      :weather -> extract_current_tag_info xml, 'weather'
      :temperature -> extract_current_tag_info xml, 'temperature_string'
      :pressure -> extract_current_tag_info xml, 'pressure_string'
      :humidity -> extract_current_tag_info xml, 'relative_humidity'
      :wind -> extract_current_tag_info xml, 'wind_string'
      :dewpoint -> extract_current_tag_info xml, 'dewpoint_string'
      :visibility -> extract_current_tag_info xml, 'visibility_mi'
    end
  end

  defp extract_current_tag_info(xml, xpath) do
    [element] = :xmerl_xpath.string(xpath, xml)
    [text] = xmlElement(element, :content)
    xmlText(text, :value)
  end
end
