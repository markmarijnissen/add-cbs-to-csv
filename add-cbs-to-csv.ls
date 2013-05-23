global <<< require './functions'
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
run(params,add-cbs-to-csv)