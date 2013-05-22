OpenOnderwijs CSV
-----------------

node.js command line to extract data from the OpenOnderwijs API to CSV

### Installation

Install [Node.js](www.nodejs.org)
```
  git clone https://github.com/markmarijnissen/openonderwijs-csv.git
  cd openonderwijs-csv
  npm install
  npm install LiveScript -g
```

Download CBS data from [http://www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/publicaties/geografische-data/archief/2013/default.htm] and unzip to `data` folder.

### Run
Interactive prompt:
```
  lsc convert
```
Make sure that the **last two columns of the CSV** are **latitude** and **longitude**