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
  =|  =pages
  |-
  ?~  raw  pages
  $(raw t.raw, pages (~(uni by pages) (fission i.raw)))
::
++  fission
  |=  =(pair cord cord)
  ^-  pages
  %-  malt
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
  ?+    (cut 3 [0 6] p.pair)  !!
      %'glossa'
    (process-glossary pair)
    ::
      %'langua'
    ~
    ::
      %'system'
    ~
    ::
      %'usersp'
    ~
  ==
++  process-glossary
  |=  =(pair cord cord)
  ^-  (list (^pair page cord))
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
++  process-hoon  !!
++  process-nock  !!
++  process-identity  !!
++  process-kernel  !!
++  process-threads  !!
--
