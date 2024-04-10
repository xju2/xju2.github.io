

# # Leaflet cluster map of talk locations
#
# (c) 2016-2017 R. Stuart Geiger, released under the MIT license
#
# Run this from the _talks/ directory, which contains .md files of all your talks. 
# This scrapes the location YAML field from each .md file, geolocates it with
# geopy/Nominatim, and uses the getorg library to output data, HTML,
# and Javascript for a standalone cluster map.
#
# Requires: glob, getorg, geopy, ipywidgets, ipyleaflet, jupyter_contrib_nbextensions

import glob
import getorg
from geopy import Nominatim
from pathlib import Path
import pickle

g = glob.glob("*.md")


geocoder = Nominatim(user_agent="mytalkmap")
location_output = "talkmap.pickle"

if Path(location_output).exists():
    with open(location_output, 'rb') as location_file:
        location_dict = pickle.loads(location_file.read())
else:
    location_dict = {}

location = ""
permalink = ""
title = ""


for file in g:
    with open(file, 'r') as f:
        lines = f.read()
        if lines.find('location: "') > 1:
            loc_start = lines.find('location: "') + 11
            lines_trim = lines[loc_start:]
            loc_end = lines_trim.find('"')
            location = lines_trim[:loc_end]
            if location not in location_dict:
                location_dict[location] = geocoder.geocode(location)
                print(location, "\n", location_dict[location])


m = getorg.orgmap.create_map_obj()
print(getorg.orgmap.output_html_cluster_map(location_dict, folder_name="../talkmap", hashed_usernames=False))

# save locations to a file
with open(location_output, 'wb') as location_file:
    location_file.write(pickle.dumps(location_dict))
