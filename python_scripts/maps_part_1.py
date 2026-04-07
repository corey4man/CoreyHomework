# Using plotly to create maps in python
# C Forman
# 7 April 2026

# load packages:
import json
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

# choropleth like a county map where each county has data, as opposed to heatmaps where each pixel is a value

# load data here (gapminder)
gap = px.data.gapminder().query("year==2007")
gap.head

# min level choropleth
fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country"
)
fig.show()

# add a title, change coloration
fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale ="Viridis",
    title= "Life Exp. By Country 2007"
)
fig.show()

# crop this map and improve labels
fig.update_layout(
    coloraxis_colorbar_title = "Years",
    margin = dict(l=0, r=0, t=50, b=0)
)

# gdp with more hovering information
fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "gdpPercap",
    hover_name = "country",
    hover_data = {
        "lifeExp":":1f", # These are all line breaks and formatting stuff we aren't learning
        "pop":":,",
        "gdpPercap":":,.0f",
        "iso_alpha":False # Would be there by default
    },
    color_continuous_scale="Plasma",
    title = "GDP Per Cap by country 2007"
)
fig.show()

# update outlines of GDP map

fig.update_geos(
    showframe = False,
    showcoastlines = False
)

# crop map to one region
americas = gap.query("continent == 'Americas'")
americas
fig = px.choropleth(
    americas,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale="Tealgrn",
    title = "Life Exp in the Americas 2007"
)
fig.show()

fig.update_geos(
    scope = "north america",
    showland = True,
    landcolor = "rgb(240,240,240)"
)

# look at some projections
fig.update_geos(projection_type="mercator")
fig.update_geos(projection_type="natural earth")
fig.update_geos(projection_type="orthographic")

# tile based choropleths

from urllib.request import urlopen

with urlopen("https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json") as response:
    county_geojson = json.load(response)

county_df = pd.read_csv(
    "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv",
    dtype={"fips": str}
)

county_df.head()

fig = px.choropleth_map(
    county_df,
    geojson=county_geojson,
    locations="fips",
    featureidkey="id",
    color="unemp",
    color_continuous_scale="Viridis",
    zoom=3,
    center={"lat": 37.8, "lon": -96},
    map_style="carto-darkmatter", # other styles include carto-positron and open-street-map
    opacity=0.7,
    title="US county unemployment"
)
fig.show()

