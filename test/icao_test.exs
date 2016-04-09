defmodule WeatherConditions.ICAO.Test do

  use ExUnit.Case

  import WeatherConditions.ICAO
  alias WeatherConditions.ICAO

  @xml '''
<?xml version="1.0" encoding="ISO-8859-1"?> 
<?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
<current_observation version="1.0"
	 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	 xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
	<credit>NOAA's National Weather Service</credit>
	<credit_URL>http://weather.gov/</credit_URL>
	<image>
		<url>http://weather.gov/images/xml_logo.gif</url>
		<title>NOAA's National Weather Service</title>
		<link>http://weather.gov</link>
	</image>
	<suggested_pickup>15 minutes after the hour</suggested_pickup>
	<suggested_pickup_period>60</suggested_pickup_period>
	<location>New York, Kennedy International Airport, NY</location>
	<station_id>KJFK</station_id>
	<latitude>40.63915</latitude>
	<longitude>-73.76393</longitude>
	<observation_time>Last Updated on Apr 9 2016, 7:51 am EDT</observation_time>
        <observation_time_rfc822>Sat, 09 Apr 2016 07:51:00 -0400</observation_time_rfc822>
	<weather>Mostly Cloudy</weather>
	<temperature_string>40.0 F (4.4 C)</temperature_string>
	<temp_f>40.0</temp_f>
	<temp_c>4.4</temp_c>
	<relative_humidity>53</relative_humidity>
	<wind_string>East at 8.1 MPH (7 KT)</wind_string>
	<wind_dir>East</wind_dir>
	<wind_degrees>70</wind_degrees>
	<wind_mph>8.1</wind_mph>
	<wind_kt>7</wind_kt>
	<pressure_string>1008.3 mb</pressure_string>
	<pressure_mb>1008.3</pressure_mb>
	<pressure_in>29.78</pressure_in>
	<dewpoint_string>24.1 F (-4.4 C)</dewpoint_string>
	<dewpoint_f>24.1</dewpoint_f>
	<dewpoint_c>-4.4</dewpoint_c>
	<windchill_string>35 F (2 C)</windchill_string>
      	<windchill_f>35</windchill_f>
      	<windchill_c>2</windchill_c>
	<visibility_mi>10.00</visibility_mi>
 	<icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
	<two_day_history_url>http://www.weather.gov/data/obhistory/KJFK.html</two_day_history_url>
	<icon_url_name>bkn.png</icon_url_name>
	<ob_url>http://www.weather.gov/data/METAR/KJFK.1.txt</ob_url>
	<disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
	<copyright_url>http://weather.gov/disclaimer.html</copyright_url>
	<privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
</current_observation>
'''

  test "returns well formatted url for icao codes" do
    ~w{KBDD kjFK kjfx kJHN}
    |> Enum.each(fn code -> assert ICAO.generate_url(code) == "http://w1.weather.gov/xml/current_obs/" <> String.upcase(code) <> ".xml" end)
  end

  test "extracts info from xml" do
    {xml, _} = :xmerl_scan.string(@xml)
    assert fetch_tag_value(xml, :location) == 'New York, Kennedy International Airport, NY'
    assert fetch_tag_value(xml, :humidity) == '53'
    assert fetch_tag_value(xml, :temperature) == '40.0 F (4.4 C)'
    assert fetch_tag_value(xml, :visibility) == '10.00'
    assert fetch_tag_value(xml, :longitude) == '-73.76393'
    assert fetch_tag_value(xml, :latitude) == '40.63915'
    assert fetch_tag_value(xml, :time) == 'Last Updated on Apr 9 2016, 7:51 am EDT'
    assert fetch_tag_value(xml, :weather) == 'Mostly Cloudy'
    assert fetch_tag_value(xml, :pressure) == '1008.3 mb'
    assert fetch_tag_value(xml, :wind) == 'East at 8.1 MPH (7 KT)'
    assert fetch_tag_value(xml, :dewpoint) == '24.1 F (-4.4 C)'
  end
end
