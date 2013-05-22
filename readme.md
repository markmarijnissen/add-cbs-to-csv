##  Add CBS regional data to a CSV
Add CBS regional data to a *.csv based on GPS(lat,long) coordinates.

```
Example input.csv:
+------+--------+-------+---------+----------+-----------+
| Name | e-mail | hobby | ..etc.. | latitude | longitude |
+------+--------+-------+---------+----------+-----------+
| Mark | mark@..| hack  | ...     | 51.8333  | 5.8667    |
| Bob  | bob@.. | eat   | ...     | 52.7237  | 5.7583    |
+------+--------+-------+---------+----------+-----------+

Example output.csv:
+------+--------+-------+---------+----------+-----------+---------+-----------+----------
| Name | e-mail | hobby | ..etc.. | latitude | longitude | WK_CODE | GM_NAAM   | + much more 
+------+--------+-------+---------+----------+-----------+---------+-----------+----------
| Mark | mark@..| hack  | ...     | 51.8333  | 5.8667    | GM0772  | Nijmegen  | + much more 
| Bob  | bob@.. | eat   | ...     | 52.7237  | 5.7583    | GM0268  | Eindhoven | + much more 
+------+--------+-------+---------+----------+-----------+---------+-----------+----------
```

### How?
The CBS regional data contains *.shp files, which define geographic areas (buurt, wijk, gemeente). These are defined as a polygon: a list of "Rijksdriehoeksmeting", in meters. 

This script transforms a decimal GPS-coordinate (e.g. 51.457723, 5.458309) to Rijksdriehoeksmeting and finds the matching region. It then extracts the CBS statistics ("Kerncijfers") and adds that to the CSV row.

### Installation

Install [Node.js](www.nodejs.org)
```
  git clone https://github.com/markmarijnissen/add-cbs-to-csv.git
  cd add-cbs-to-csv
  npm install
  npm install LiveScript -g
```

Download CBS data [here](http://www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/publicaties/geografische-data/archief/2013/default.htm) and unzip to `data` folder.

### Run
Interactive prompt:
```
  lsc convert
```
Make sure that the **last two columns of the CSV** are **latitude** and **longitude**


### Todo [for speedup]
This is a quick 'n dirty hack. If speed is an issue, here is how to improve performance:

* Use csv-parse `transform` instead of `fs.appendFile`