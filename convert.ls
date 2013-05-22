_ = require 'prelude-ls'
shp = require 'shp'
colors = require('colors')
rd = require './rd'
csv = require 'csv'
fs = require 'fs'
pointInPolygon = require('./pointInPolygon')
global <<< require './functions'

convert = (args) ->
  (err,data) <- shp.readFile args.shp
  columns = ["lat","lng"] ++ [key.trim! for key,value of data.features[0].properties]
  write-csv-header(args.output,columns)
  csv()
    ..from(args.input)
    ..on 'record', (row,index) ->
      [lat,lng] = [row[*-2]*1.0,row[*-1]*1.0]
      x = rd.x(lat,lng)
      y = rd.y(lat,lng)
      if index is 0 then return
      if index is 1 then
        console.log "Latitude = #{lat} (groot); Longitude = #{lng} (klein)".yellow
        console.log "RD-X = #{x}, RD-Y = #{y}".yellow
      for item in data.features when pointInPolygon(item.geometry.coordinates[0],x,y)
        values = [lat,lng] ++ [value.trim! for key,value of item.properties]
        write-csv-row(args.output,values)

params = 
    * name: 'input'
      description: 'input lat-long .csv'
      default: 'latlong.csv'
    * name: 'shp'
      description: 'CBS .shp'
      default: 'data/wijk_2012_v1'
    * name: 'output'
      description: 'output .csv'
      default: 'output.csv'
run(params,convert)