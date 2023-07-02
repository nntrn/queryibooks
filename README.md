# queryibooks

- **queryibooks**: Get annotations from iBooks
- **ibooks2dayone**: Create DayOne import for iBook annotations

## Setup

```sh
mkdir -p ~/bin && cd $_
curl -O https://raw.githubusercontent.com/nntrn/queryibooks/main/queryibooks
curl -O https://raw.githubusercontent.com/nntrn/queryibooks/main/ibooks2dayone
chmod a+x {queryibooks,ibooks2dayone}
```

## Usage

```console
$ queryibooks >ibooks.json
$ ibooks2dayone ibooks.json
```


![](assets/dayone.png)


