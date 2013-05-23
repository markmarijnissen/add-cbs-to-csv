global <<< require './src/functions'
params = 
    * name: 'input'
      description: 'Input CSV'
      default: 'input.csv'
    * name: 'shp'
      description: 'CBS *.shp'
      default: 'data/wijk_2012_v1'
    * name: 'output'
      description: 'Output CSV'
      default: 'output.csv'
run(params,add-cbs-to-csv)