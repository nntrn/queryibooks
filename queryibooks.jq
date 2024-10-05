def nsdate2unix($ts; $fmt): ($ts // 0 | tonumber) + 978307200 | strflocaltime($fmt);
def nsdate2unix($ts):  nsdate2unix($ts; "%FT%TZ");
def nsdate2unix: nsdate2unix(.; "%FT%TZ");

def map_annotations: {
  Z_PK,
  ZANNOTATIONCREATIONDATE: nsdate2unix(.ZANNOTATIONCREATIONDATE),
  ZANNOTATIONASSETID,
  ZANNOTATIONSELECTEDTEXT,
  ZFUTUREPROOFING5,
  ZANNOTATIONNOTE,
  ZANNOTATIONLOCATION,
  ZPLLOCATIONRANGESTART
};

def map_assets: { 
  ZASSETID, 
  ZTITLE, 
  ZAUTHOR, 
  ZGENRE, 
  ZASSETGUID 
};

def create_annnotations: 
  INDEX($assets[][]; .ZASSETID) as $c 
  | map(map_annotations + ($c[.ZANNOTATIONASSETID]|map_assets))
  | map(del(.ZANNOTATIONASSETID))
  ;

def h2:
  if ((.|type) == "string" and (.|gsub(" "; "")? // ""|length) > 0)
  then "\n\n---\n\n## \(. | gsub("…";"."))\n"
  else "\n---\n"
  end;

def remove_citations:
  gsub("[\\n]{2,}";"\n\n") | gsub("(?<a>[^ \n])[0-9]+\n"; "\(.a)\n"; "m");


def create_dayone_import:
  map(. + {chapter: (.ZANNOTATIONLOCATION|[match("\\[([^\\]]+)\\]+";"g").captures[].string|gsub("^.*-|\\..*";"")]|first)})
  | group_by(.ZASSETID) 
  | map(select(length>1))
  | map({
      title: .[0].ZTITLE,
      author: .[0].ZAUTHOR,
      uuid: (.[0].ZASSETGUID|gsub("-";"")? // ""),
      creationDate: min_by(.ZANNOTATIONCREATIONDATE).ZANNOTATIONCREATIONDATE,
      modifiedDate: max_by(.ZANNOTATIONCREATIONDATE).ZANNOTATIONCREATIONDATE,
      isAllDay: false,
      isPinned: false,
      starred: false,
      timeZone: "America/Chicago",
      tags: (.[0].ZGENRE? // ""|ascii_downcase|split(" & ")|map(gsub(" ";"-"))),
      text: (
        group_by(.chapter)
        | map(
          [
            (.[0].ZFUTUREPROOFING5| h2)?,
            map(("* \(.ZANNOTATIONSELECTEDTEXT)"| split("\n") | map(select((gsub("[\r\n\t]"; "")? |length) > 3 )))
              | join(" ") | gsub("[\t\r]";" ") | gsub("[ ]{1,}";" ") )
          ] | flatten | join("\n\n"))
        | flatten | join("\n")
      )
    })
  | map (. + {text: ( "# \(.title)\n\nby \(.author)\n\(.text| remove_citations |gsub("[\\n]{2,}";"\n\n") )\n") })
  | sort_by(.modifiedDate)
  | { metadata: {version: "1.0"}, entries: map(del(.title,.author)) }
  ;



# .ZANNOTATIONLOCATION|[match("\\[([^\\]]+)\\]+";"g").captures[].string|gsub("^.*-|\\..*";"")]|first
def create_dayone_import2:


  map(. + (.ZANNOTATIONLOCATION|capture("\\[(?<chapter>[^\\]]+)\\].*/(?<location>.*)\\)" )))
  | map(select((.ZTITLE) and (.ZANNOTATIONSELECTEDTEXT|length) >10 ))
  # | sort_by(.ZANNOTATIONLOCATION)
  # | group_by(.ZSORTTITLE)
  # | map(select(length>1))
  # | map({
  #     title: .[0].ZTITLE,
  #     author: .[0].ZAUTHOR,
  #     uuid: (.[0].ZASSETGUID|gsub("-";"")? // ""),
  #     creationDate: min_by(.ZANNOTATIONCREATIONDATE).ZANNOTATIONCREATIONDATE,
  #     modifiedDate: max_by(.ZANNOTATIONCREATIONDATE).ZANNOTATIONCREATIONDATE,
  #     isAllDay: false,
  #     isPinned: false,
  #     starred: false,
  #     timeZone: "America/Chicago",
  #     tags: (.[0].ZGENRE|ascii_downcase|split(" & ")|map(gsub(" ";"-"))),
  #     text: (
  #       group_by(.chapter)
  #       | map(
  #         [
  #           (.[0].ZFUTUREPROOFING5| h2)?,
  #           map(("* \(.ZANNOTATIONSELECTEDTEXT)"| split("\n") | map(select((gsub("[\r\n\t]"; "")? |length) > 3 )))
  #             | join(" ") | gsub("[\t\r]";" ") | gsub("[ ]{1,}";" ") )
  #         ] | flatten | join("\n\n"))
  #       | flatten | join("\n")
  #     )
  #   })
  # | map (. + {text: ( "# \(.title)\n\nby \(.author)\n\(.text| remove_citations |gsub("[\\n]{2,}";"\n\n") )\n") })
  # | sort_by(.modifiedDate)
  # | { metadata: {version: "1.0"}, entries: map(del(.title,.author)) }
  ;