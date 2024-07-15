#   `%don`: Online `man` pages for `docs.urbit.org`

**WIP ~2024.7.15. Code being produced actively.**

```
dojo> |link %don

::  Ctrl-X

don> |%
|% "barcen"
Produce a core, [battery payload].

Syntax
Argument: a variable number of +-family expressions.
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
