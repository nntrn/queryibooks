# queryibooks

- **queryibooks**: Get annotations from iBooks
- **ibooks2dayone**: Create DayOne import for iBook annotations

## Usage

```console
$ queryibooks

[
  {
    "Z_PK": 6113,
    "ZANNOTATIONCREATIONDATE": "2024-10-04T04:28:12Z",
    "ZANNOTATIONSELECTEDTEXT": "In terms of thematics, she had got many things right in line with the market’s taste. Two topics taking 30 percent of the novel? Check. A third topic taking us to 40 percent? Check. Closeness as one of those topics? Check. These are the tricks, conscious or unconscious, of hundreds of NYT bestselling authors, in all different genres.",
    "ZFUTUREPROOFING5": null,
    "ZANNOTATIONNOTE": null,
    "ZANNOTATIONLOCATION": "epubcfi(/6/18[chapter3]!/4/30,/3:1270,/5:46)",
    "ZPLLOCATIONRANGESTART": 8,
    "ZASSETID": "1078221643",
    "ZTITLE": "The Bestseller Code",
    "ZAUTHOR": "Jodie Archer & Matthew L. Jockers",
    "ZGENRE": "Literary Criticism",
    "ZASSETGUID": "97F10B45-10EA-44C1-A501-1CAE7802E450"
  },
  ...
]
```

### DayOne

<center><img src="assets/dayone.png" width="70%"/></center>

```console
$ queryibooks | ibooks2dayone
Reading assets from /Users/annie/.cache/queryibooks/2023-08-02-12/assets.json
Reading annotations from /Users/annie/.cache/queryibooks/2023-08-02-12/annotations.json

Done!
Import /Users/annie/Downloads/ibooks-dayone-2023-08-02-12-45.zip to Day One
```


