# load packages:
import json
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

# load data here (gapminder)
gap = px.data.gapminder().query("year==2018")

# Question 1

fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "gdpPercap",
    hover_name = "country",
    hover_data = {
        "pop":":,",
        "gdpPercap":":,.0f",
        "iso_alpha":False
    },
    color_continuous_scale="Viridis",
    title = "GDP Per Cap by country 2007"
)
fig.show()
