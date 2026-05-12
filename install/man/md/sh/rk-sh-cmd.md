# Group Commands

```
{ ~/.bin/nobin/_egit.sh -p || ~/.bin/nobin/_egit.sh -n; } && ~/.bin/sgitt-auto
```

Exiting on failure:

```
{ ~/.bin/nobin/_egit.sh -p || ~/.bin/nobin/_egit.sh -n && exit 1; } && ~/.bin/sgitt-auto
```
