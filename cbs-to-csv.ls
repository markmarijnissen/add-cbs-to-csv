global <<< require './src/functions'
params = 
    * name: 'shp'
      description: 'CBS *.shp'
      default: 'data/wijk_2012_v1'
    * name: 'output'
      description: 'Output CSV'
      default: 'output.csv'
run(params,cbs-to-csv)