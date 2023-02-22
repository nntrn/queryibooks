def map_assets:
  {
    ZASSETID,
    ZTITLE,
    ZAUTHOR,
    ZASSETGUID,
    ZGENRE,
    ZSTOREID,
    ZSORTTITLE,
    ZSORTAUTHOR
  }
  ;

def epoch_date:
  ((.// 0)+978307200|todate|gsub("T.*";""))
  ;

def map_annotations:
  {
    Z_PK,
    ZANNOTATIONUUID,
    ZANNOTATIONCREATIONDATE,
    ZANNOTATIONMODIFICATIONDATE,
    ZANNOTATIONASSETID,
    ZANNOTATIONSTYLE,
    ZANNOTATIONTYPE,
    ZANNOTATIONSELECTEDTEXT
  };

def combine_json_files:
  reduce inputs as $s (.; .[input_filename|gsub(".json";"")|split("/")|last] += $s)
  ;

def detailed_annotations:
  INDEX(.assets[]; .ZASSETID) as $c
    | .annotations
    | map( (map_annotations) + ($c[.ZANNOTATIONASSETID]|map_assets)
  )
  ;

def ibooks_data:
  combine_json_files
  | detailed_annotations
  | map({
    pid:.Z_PK,
    store_id: .ZSTOREID,
    title: .ZTITLE,
    author: .ZAUTHOR,
    created: (.ZANNOTATIONCREATIONDATE|epoch_date),
    modified: (.ZANNOTATIONMODIFICATIONDATE|epoch_date),
    genre: .ZGENRE,
    text: .ZANNOTATIONSELECTEDTEXT
  });
