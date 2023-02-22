# queryibooks

Get annotations with from Apple Books

```sh
git clone https://github.com/nntrn/queryibooks.git
EXECPATH=$PWD/queryibooks/queryibooks
chmod a+x $EXECPATH
mkdir -p $HOME/bin
cd $HOME/bin
ln -s $EXECPATH .
```

## Usage

```sh
queryibooks --out <DIR>
queryibooks --print assets
queryibooks --print data
queryibooks --print annotations
```

## Result

### data.json

```json
[
  {
    "pid": 1584,
    "store_id": "1558619592",
    "title": "Brave New World",
    "author": "Aldous Huxley",
    "created": "2023-02-12",
    "modified": "2023-02-12",
    "genre": "Classics",
    "text": "Well, duty's duty. One can't consult one's own preferences. I'm interested in truth, I like science. But truth's a menace, science is a public danger. As dangerous as it's been beneficent"
  }
]
```


## Requirements

- jq (tested against 1.6)
- sqlite3 (tested against 3.39.5)
