#   `%don`: Online `man` pages for `docs.urbit.org`

**WIP ~2024.7.16. Working prototype.**

- The docs cache works.
- No full-text search yet.
- Display is staggered rather than carriage-returned.

---

`%don` keeps a cache of online documentation from [`docs.urbit.org`](https://docs.urbit.org)
queryable by developers at the command-line interface.

```
dojo> |link %don

::  Ctrl-X

don> |%
|% "barcen"
Produce a core, [battery payload].

Syntax
Argument: a variable number of +-family expressions.

don> weld
++weld
Concatenate

Concatenate two ++lists a and b.

Accepts
a and b are lists.
```

After initial boot, the docs can be updated dynamically:

```
dojo> :don|sync
```

The search can be effected manually as well at the `don>` prompt:

```
dojo> :don|find '|%'
```

![](logo.webp)
