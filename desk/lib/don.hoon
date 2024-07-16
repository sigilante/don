  ::  /lib/don
::::
::
/-  *don
/+  re=regex,
    se=seq
|%
++  take-action
  |=  [act=action =bowl:gall]
  ^-  (list card:agent:gall)
  ?-    -.act
      %sync
    =/  tid  `@ta`(cat 3 'thread_' (scot %uv (sham eny.bowl)))
    =/  ta-now  `@ta`(scot %da now.bowl)
    =/  start-args  [~ `tid byk.bowl(r da+now.bowl) %retrieve-docs !>(~)]
    ~&  >  'syncing'
    :~  :*  %pass   /thread/[ta-now]
            %agent  [our.bowl %spider]
            %watch  /thread-result/[tid]
        ==
        :*  %pass   /thread/[ta-now]
            %agent  [our.bowl %spider]
            %poke   %spider-start  !>(start-args)
        ==
        :*  %pass   /thread/updates/[ta-now]
            %agent  [our.bowl %spider]
            %watch  /thread/[tid]/updates
    ==  ==
    ::
      %find
    ~&  >  cord.act
    ~
  ==
::
++  find-text
  |=  [=cord =pages]
  ^-  (unit page)
  !!
::
++  parse-pages
  |=  raw=(list (pair cord cord))
  ^-  pages
  =|  pages=(list (pair cord cord))
  |-
  ~&  >>  "{<(lent raw)>} pages left to parse."
  ?~  raw  (malt pages)
  ~&  >>  "  {<p.i.raw>} up."
  $(raw t.raw, pages (weld (fission i.raw) pages))
::
++  fission
  |=  =(pair cord cord)
  ^-  (list (^pair page cord))
  ::  We have several kinds of incoming files to
  ::  parse into data.  Since this is reference
  ::  material, we don't expect the form to change
  ::  very much in the future.
  ::  - /glossary
  ::  - /language/hoon/reference
  ::  - /language/nock
  ::  - /system/identity
  ::  - /system/kernel
  ::  - /userspace/threads
  ?+    (cut 3 [0 3] p.pair)  !!
      %'glo'
    (process-glossary pair)
    ::
      %'lan'
    ?+  (cut 3 [9 4] p.pair)  !!
      %'hoon'  (process-hoon pair)
      %'nock'  (process-nock pair)
    ==
    ::
      %'sys'
    ~
    ::
      %'use'
    ~
  ==
++  process-glossary
  |=  =(pair cord cord)
  ^-  (list (^pair cord cord))
  ::  Each glossary entry is in its own file, so it's
  ::  easy to parse out.
  :~  :-  (cut 3 [(lent "glossary/") (sub (lent (trip p.pair)) (add (lent ".md") (lent "glossary/")))] p.pair)
      ::  Grab the section between the second `+++` and
      ::  the `##  Further Reading`, if any.
      =/  body  (trip q.pair)
      =/  sxns  (split-all:se body "+++")
      =/  sxn  (snag 2 sxns)
      =/  beg  (lent "\0a\0a")
      =/  end
        ?~  (find "Further Reading" sxn)  (lent sxn)
      (need (find "\0a\0a" (flop sxn)))
      =.  sxn  `trip`(swag [beg end] sxn)
      (crip sxn)
  ==
++  process-hoon
  |=  =(pair cord cord)
  ^-  (list (^pair cord cord))
  ::  Each Hoon entry is sewn into a bundle on each
  ::  page, so we need to parse out the individual
  ::  entries.
  ::  language/hoon/reference/rune/cen
  |^
  ~&  >>>  (cut 3 [24 4] p.pair)
  ?+    (cut 3 [24 4] p.pair)
             (process-main pair)
    %'limb'  (process-hoon-limb pair)
    %'rune'  (process-hoon-rune pair)
    %'stdl'  (process-hoon-stdlib pair)
    %'zuse'  (process-hoon-zuse pair)
  ==
  ++  process-main
    |=  =(^pair cord cord)
    ^-  (list (^^pair cord cord))
    ~
  ++  process-hoon-limb
    |=  =(^pair cord cord)
    ^-  (list (^^pair cord cord))
    ~
  ++  process-hoon-rune
    |=  =(^pair cord cord)
    ^-  (list (^^pair cord cord))
    ::  Grab the header for the rune type, then
    ::  the rest of the entries with <h2> title.
    =/  body  (trip q.pair)
    =/  sxns  (split-all:se body "+++")
    =/  runes  (split-all:se (snag 2 sxns) "\0a## ")
    =/  fam  (cut 3 [0 3] (crip (head (flop (split-all:se (trip p.pair) "/")))))
    ::  Treat constants separately.
    ?:  =('con' fam)  ~
    %+  weld
      ^-  (list (^^pair cord cord))
      ::  Treat terminators separately.
      ?:  =('ter' fam)  ~
      ~[[(~(got by larua) fam) (crip (snag 0 runes))]]
    ^-  (list (^^pair cord cord))
    %+  weld
      %+  turn
        (slag 1 runes)
      |=  =tape
      ^-  (^^pair cord cord)
      :-  (crip (slag 2 (scag 3 tape)))
      (crip (slag 15 tape))
    %+  turn
      (slag 1 runes)
    |=  =tape
    ^-  (^^pair cord cord)
    ~&  >>  (crip (scag 6 (slag 6 tape)))
    :-  (crip (scag 6 (slag 6 tape)))
    (crip (slag 15 tape))
  ++  process-hoon-stdlib
    |=  =(^pair cord cord)
    ^-  (list (^^pair cord cord))
    ~
  ++  process-hoon-zuse
    |=  =(^pair cord cord)
    ^-  (list (^^pair cord cord))
    ~
  --
++  process-nock
  |=  =(pair cord cord)
  ^-  (list (^pair cord cord))
  ~&  >>>  pair
  ~
++  process-identity  !!
++  process-kernel  !!
++  process-threads  !!
::
++  aural
  ^~
  ^-  (map cord cord)
  %-  malt
  ^-  (list (pair cord cord))
  :~  :-  '|'   'bar'
      :-  '\\'  'bas'
      :-  '$'   'buc'
      :-  '_'   'cab'
      :-  '%'   'cen'
      :-  ':'   'col'
      :-  ','   'com'
      :-  '"'   'doq'
      :-  '.'   'dot'
      :-  '/'   'fas'
      :-  '<'   'gal'
      :-  '>'   'gar'
      :-  '#'   'hax'
      :-  '-'   'hep'
      :-  '{'   'kel'
      :-  '}'   'ker'
      :-  '^'   'ket'
      :-  '+'   'lus'
      :-  ';'   'mic'
      :-  '('   'pal'
      :-  '&'   'pam'
      :-  ')'   'par'
      :-  '@'   'pat'
      :-  '['   'sel'
      :-  ']'   'ser'
      :-  '~'   'sig'
      :-  '\''  'soq'
      :-  '*'   'tar'
      :-  '`'   'tic'
      :-  '='   'tis'
      :-  '?'   'wut'
      :-  '!'   'zap'
  ==
::
++  larua
  ^~
  ^-  (map cord cord)
  %-  malt
  ^-  (list (pair cord cord))
  :~  :-  'bar'  '|'
      :-  'bas'  '\\'
      :-  'buc'  '$'
      :-  'cab'  '_'
      :-  'cen'  '%'
      :-  'col'  ':'
      :-  'com'  ','
      :-  'doq'  '"'
      :-  'dot'  '.'
      :-  'fas'  '/'
      :-  'gal'  '<'
      :-  'gar'  '>'
      :-  'hax'  '#'
      :-  'hep'  '-'
      :-  'kel'  '{'
      :-  'ker'  '}'
      :-  'ket'  '^'
      :-  'lus'  '+'
      :-  'mic'  ';'
      :-  'pal'  '('
      :-  'pam'  '&'
      :-  'par'  ')'
      :-  'pat'  '@'
      :-  'sel'  '['
      :-  'ser'  ']'
      :-  'sig'  '~'
      :-  'soq'  '\''
      :-  'tar'  '*'
      :-  'tic'  '`'
      :-  'tis'  '='
      :-  'wut'  '?'
      :-  'zap'  '!'
  ==
--
