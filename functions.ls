fs = require('fs')
prompt = require('prompt')
_ = require('prelude-ls')

config =
    delimiter: ","
    quotechar: '"'
    lineterminator: "\r\n"
    alwaysquote: no
    allcolumns: yes

module.exports =
  config: config

  run: (params,func) ->
    input = false
    if process.argv.length is 5
      try
        input.input = require("./"+process.argv[2])
        input.shp = require("./"+process.argv[3])
        input.output = require('./'+process.argv[4])
    if not input
      prompt.start!
      (err,input) <- prompt.get params
      func(input)
    else
      func(input)

  csv-field: (string) -> 
    string = string+""
    regex = new RegExp(config.quotechar,'g')
    string = string.replace regex,config.quotechar+config.quotechar
    if config.alwaysquote or string.match("(#{config.quotechar}|#{config.delimiter}|#{config.lineterminator})") isnt null
      string = config.quotechar+string+config.quotechar
    string

  write-csv-row: (filename,values) ->
    row =_.map(csv-field,values).join(config.delimiter)+config.lineterminator
    fs.appendFile filename,row

  write-csv-header: (filename,columns) ->
    header = _.map(csv-field,columns).join(config.delimiter)+config.lineterminator
    fs.writeFile filename,header