#!/usr/bin/env python

import json
from urllib.request import urlopen
from jproperties import Properties
import argparse


def degrees_to_cardinal(d):
    dirs = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
            'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW']
    ix = round(d / (360. / len(dirs)))
    return dirs[ix % len(dirs)]


# weather icons
weather_icons = {
    "Sunny": "",
    "Mostly Sunny": "",
    "Mostly Clear": "",
    "Partly Cloudy": "",
    "Cloudy": "",
    "Thunderstorms": "",
    "Few Showers": "",
    "Showers": "",
    "Light Rain": "",
    "Scattered Thunderstorms": "",
    "default": "",
}

parser = argparse.ArgumentParser()
parser.add_argument("-c", "--config", type=str)

args = parser.parse_args()
config_file = args.config

print(config_file)

configs = Properties()
with open(config_file, 'rb') as config_file:
    configs.load(config_file)

api_key = configs.get("apiKey").data

url = str.format(
    "{}", f"https://api.weather.com/v2/pws/observations/current?stationId=IMOGOR2&format=json&units=m&numericPrecision=decimal&apiKey={api_key}")
json_data = json.load(urlopen(url=url))

lat = json_data["observations"][0]['lat']
lon = json_data["observations"][0]['lon']


url = str.format(
    "{}{}{}", f'https://api.weather.com/v3/wx/forecast/daily/5day?geocode={lat},', f'{lon}&format=json&units=m&language=en-US&apiKey=', f'{api_key}')
json_data_forecast = json.load(urlopen(url=url))

# location
location = json_data["observations"][0]['neighborhood']

# current temperature
temp = json_data["observations"][0]['metric']['temp']
# print(temp)

# current status phrase
status = json_data_forecast['narrative'][0]

status_code = json_data_forecast['daypart'][0]['wxPhraseLong'][1]

# status icon
icon = (
    weather_icons[status_code]
    if status_code in weather_icons
    else weather_icons["default"]
)
# print(icon)

# temperature feels like
temp_feel = json_data["observations"][0]['metric']['heatIndex']
temp_feel_text = f"Feels like {temp_feel}°"

dew_point = json_data['observations'][0]['metric']['dewpt']
dew_point_text = f"Dew point {dew_point}°"

wind_chill = json_data['observations'][0]['metric']['windChill']
wind_chill_text = f"Wind chill {wind_chill}°"
# print(temp_feel_text)

# min-max temperature
#
temp_min = json_data_forecast['calendarDayTemperatureMin'][0]
temp_max = json_data_forecast['calendarDayTemperatureMax'][0]
# print(temp_min)

temp_min_max = f"  {temp_min}°\t\t  {temp_max}°"
# print(temp_min_max)

# wind speed
wind_speed = json_data["observations"][0]['metric']['windSpeed']
wind_dir = json_data["observations"][0]['winddir']

cardinal = degrees_to_cardinal(wind_dir)
wind_text = f" {cardinal} {wind_speed} Km/h"
# print(wind_text)

# humidity
humidity = json_data["observations"][0]['humidity']
humidity_text = f" {humidity}%"

# pressure
pressure = json_data["observations"][0]['metric']['pressure']
pressure_text = f" {pressure}hPa"

# rain
rain_rate = json_data["observations"][0]['metric']['precipRate']
rain_rate_text = f" {rain_rate}mm/h"
rain_total = json_data["observations"][0]['metric']['precipTotal']
rain_total_text = f" { rain_total}mm"

# print(humidity_text)

# tooltip text
tooltip_text = str.format(
    "{}{}{}{}{}{}{}{}{}",
    f'<big>{location} {icon}</big>\n',
    f'<span size="xx-large">{temp}°</span>\n',
    f"<big>{temp_min_max}</big>\n\n",
    f"<big>{status}</big>\n\n",
    f"<small>{temp_feel_text}</small>\n",
    f"<small>{dew_point_text}</small>\n",
    f"<small>{wind_chill_text}</small>\n\n",
    f"<small>{wind_text}\n{humidity_text}\n{pressure_text}</small>\n",
    f"<small>{rain_rate_text}\n{rain_total_text}</small>"
)

# print waybar module data
out_data = {
    "text": f"<span rise='1000'>{icon}</span> {temp}",
    "alt": status,
    "tooltip": tooltip_text,
    "class": status_code.replace(" ", ""),
}
print(json.dumps(out_data))

