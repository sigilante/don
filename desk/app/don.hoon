  ::  /app/don
::::
::
/-  *don
/+  dbug,
    default-agent,
    *don,
    shoe,
    sole,
    verb
|%
+$  versioned-state
  $%  state-zero
  ==
+$  card  card:agent:shoe
+$  command  @t
--
%+  verb  &
%-  agent:dbug
=|  state-zero
=*  state  -
^-  agent:gall
%-  (agent:shoe command)
^-  (shoe:shoe command)
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
    leather  ~(. (default:shoe this command) bowl)
++  on-init
  ^-  [(list card) _this]
  [~ this]
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  [(list card) _this]
  :-  ^-  (list card)
      ~
  %=  this
    state  !<(state-zero old)
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  [(list card) _this]
  ?+    mark  (on-poke:default mark vase)
      %don-action
    :_  this
    (take-action !<(action vase) bowl)
    ::
      %sole-action
    [~ this]
  ==
::
++  on-peek
  |=  path=(pole knot)
  ^-  (unit (unit cage))
  ?+    path  (on-peek:default path)
    [%x %pages ~]  [~ ~ [%noun !>(pages)]]
  ==
++  on-watch
  |=  path=(pole knot)
  ^-  [(list card) _this]
  [~ this]
++  on-arvo   on-arvo:default
++  on-leave  on-leave:default
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  [(list card) _this]
  ?+    -.wire  (on-agent:default wire sign)
    %thread
    ?+    -.sign  (on-agent:default wire sign)
        %poke-ack
      ?~  p.sign
        [~ this]
      ~&  >>>  "Thread failed to start"
      [~ this]
    ::
        %fact
      ?+    p.cage.sign  (on-agent:default wire sign)
          %thread-fail
        =/  err  !<  (pair term tang)  q.cage.sign
        ~&  >>>  "Thread failed: {(trip p.err)}\0a{<q.err>}"
        [~ this]
          %thread-done
        =/  res  !<((list (pair cord cord)) q.cage.sign)
        [~ this(pages (parse-pages res))]
      ==
    ==
  ==
++  on-fail   on-fail:default
++  command-parser
  |=  =sole-id:shoe
  ^+  |~(nail *(like [? command]))
  (stag | (boss 256 (more gon qit)))
++  on-command
  |=  [=sole-id:shoe =command]
  ^-  (quip card _this)
  :_  this
  ^-  (list card)
  :~  :+  %shoe  ~
  ^-  shoe-effect:shoe
  :-  %sole
  ^-  sole-effect:sole  :-  %klr
  ^-  styx
  =/  idx  0
  =|  fx=styx
  =/  rng  ~(. og eny:bowl)
  |-
  ?:  =(80 idx)  fx
  =^  huer  rng  (rads:rng 256)
  =^  hueg  rng  (rads:rng 256)
  =^  hueb  rng  (rads:rng 256)
  %=  $
    idx  +(idx)
    fx   `styx`(weld fx `styx`~[[[`%br ~ `[r=`@ux`huer g=`@ux`hueg b=`@ux`hueb]] command ~]])
  ==  ==
++  can-connect
  |=  =sole-id:shoe
  ^-  ?
  ?|  =(~zod src.bowl)
      (team:title [our src]:bowl)
  ==
++  on-connect     on-connect:leather
++  on-disconnect  on-disconnect:leather
++  tab-list       tab-list:leather
--
