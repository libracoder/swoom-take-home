import os
import bios
chart = bios.read('./swoom-chart/Chart.yaml')
f = open("SWOOM_CHART_VERSION.txt", "w")
f.write(chart['version'])
f.close()


