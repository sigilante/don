::  Retrieve the Markdown contents of docs.urbit.org.
::  Derived from pkova/deployer/ted/sync.hoon
::
/-  spider
/+  strandio
=>
|%
+$  github
  $:  path=@t
      mode=@t
      type=@t
      url=@t
  ==
++  from-json
  =,  dejs:format
  ^-  $-(json (list github))
  %-  ar
  %-  ot
  :~
    [%path so]
    [%mode so]
    [%type so]
    [%url so]
  ==
::
++  build-tree-request
  |=  [repo=path commit=cord]
  ^-  card:agent:gall
  =/  url  (cat 3 (cat 3 (crip "https://api.github.com/repos{<repo>}/git/trees/") commit) '?recursive=true')
  =/  =request:http  ~[%'GET' url ~[['User-Agent' 'vere-v1.20'] ['Accept' 'application/vnd.github.v3+json']]]
  =/  =task:iris  [%request request *outbound-config:iris]
  [%pass /http-req %arvo %i task]
::
++  build-file-request
  |=  [repo=path commit=cord path=cord]
  ^-  card:agent:gall
  =/  url  (cat 3 (cat 3 (crip "https://raw.githubusercontent.com{<repo>}/") commit) (cat 3 '/' path))
  =/  =request:http  ~[%'GET' url ~[['User-Agent' 'vere-v1.20']]]
  =/  =task:iris  [%request request *outbound-config:iris]
  [%pass /http-req %arvo %i task]
--
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
;<  =bowl:spider  bind:m  get-bowl:strandio
=/  repo=path    /urbit/'docs.urbit.org'
=/  branch=cord  'master'
~&  >  "Retrieving latest commit from https://github.com{<repo>}."
=/  tid  `cord`(cat 3 'strand_' (scot %uv (sham %retrieve-latest-commit eny.bowl)))
;<  ~       bind:m  %-  watch-our:strandio
                    :*  /awaiting/[tid]
                        %spider
                        /thread-result/[tid]
                    ==
;<  ~       bind:m  %-  poke-our:strandio
                    :*  %spider
                        %spider-start
                        !>  :*  `tid.bowl
                                `tid
                                byk.bowl(r da+now.bowl)
                                %retrieve-latest-commit
                                !>(`[repo branch])
                    ==      ==
;<  =cage   bind:m  (take-fact:strandio /awaiting/[tid])
;<  ~       bind:m  (take-kick:strandio /awaiting/[tid])
?:  =(%thread-fail p.cage)
  (strand-fail:strandio !<([term tang] q.cage))
?>  ?=(%thread-done p.cage)
=/  commit  ;;(cord q.q.cage)
::
~&  >  "Retrieving file list in /desk."
;<  ~  bind:m  (send-raw-card:strandio (build-tree-request repo commit))
;<  res=(pair wire sign-arvo)  bind:m  take-sign-arvo:strandio
?.  ?=([%iris %http-response %finished *] q.res)
  (strand-fail:strand %bad-sign ~)
?~  full-file.client-response.q.res
  (strand-fail:strand %no-body ~)
=/  res  (need (de:json:html q.data.u.full-file.client-response.q.res))
?>  ?=(%o -.res)
=/  res  (from-json (~(got by p.res) 'tree'))
=/  res
  %+  skim
    res
  |=  g=github
  ?&  =('blob' type.g)                  :: only files, not trees
      !=('120000' mode.g)               :: do not resolve symlinks
      =('content/' (cut 3 [0 8] path.g))   :: only grab from /contents
      !=('content/courses/' (cut 3 [0 16] path.g)) :: do not grab courses
      !=('content/manual/' (cut 3 [0 15] path.g))  :: do not grab manual
      !=('content/tools' (cut 3 [0 13] path.g))    :: do not grab tools
      =("dm." (scag 3 (flop (trip (rear (stab (crip (cass (trip (cat 3 '/' path.g))))))))))
                                        :: only grab Markdown files
      !=("dm.xedni_" (scag 9 (flop (trip (rear (stab (crip (cass (trip (cat 3 '/' path.g))))))))))
                                        :: don't grab index files
      !=("dm.scod" (scag 7 (flop (trip (rear (stab (crip (cass (trip (cat 3 '/' path.g))))))))))
                                        :: don't grab docs.md file
  ==
::
=|  pages=(list (pair cord cord))
|-
?~  res  (pure:m !>(pages))
;<  ~  bind:m  (send-raw-card:strandio (build-file-request repo commit path.i.res))
;<  new=(pair wire sign-arvo)  bind:m  take-sign-arvo:strandio
?.  ?=([%iris %http-response %finished *] q.new)
  (strand-fail:strand %bad-sign ~)
?~  full-file.client-response.q.new
  (strand-fail:strand %no-body ~)
=/  n  (cut 3 [8 (sub (met 3 path.i.res) 8)] path.i.res)
=/  s  data.u.full-file.client-response.q.new
:: ~&  >>  [`cord`n `@ui`(met 3 q.s)]
$(pages `(list (pair cord cord))`[[n q.s] pages], res t.res)
