_ = require 'prelude-ls'
shp = require 'shp'
colors = require('colors')
rd = require './rd'
csv = require 'csv'
fs = require 'fs'
pointInPolygon = require('./pointInPolygon')
global <<< require './functions'

convert = (args) ->
  console.log "reading *.shp...".yellow
  (err,data) <- shp.readFile args.shp
  if err then
    console.error "Error parsing #{args.shp}:".red,err
    process.exit(1)
    return
  console.log "reading *.csv...".yellow
  csv()
    ..from.path(args.input)
    ..on 'record', (row,index) ->
      [lat,lng] = [row[*-2]*1.0,row[*-1]*1.0]
      x = rd.x(lat,lng)
      y = rd.y(lat,lng)
      if index is 0 
        console.log "converting...".yellow
        if isNaN(lat) then 
          header = row
        else
          header = ["?" for til row.length-2] ++ ["latitude","longitude"] 
        header = header ++ [key.trim! for key,value of data.features[0].properties]
        write-csv-header(args.output,header)
        return
      if index is 1 then
        console.log "Double-check coordinates for correct linking:"
        console.log "Latitude = #{lat} (~53); Longitude = #{lng} (~3)".cyan
        console.log "RD-X = #{x}, RD-Y = #{y}".cyan
      for item in data.features when pointInPolygon(item.geometry.coordinates[0],x,y)
        values = row ++ [value.trim! for key,value of item.properties]
        write-csv-row(args.output,values)
    ..on 'end', -> console.log "Done!".green.bold
    ..on 'error', (err) -> console.error "Error parsing #{args.input}:",err.message    

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