# Bash Commands

## Group Commands

```
{ ~/.bin/egit -p || ~/.bin/egit -n; } && ~/.bin/sgitt_auto
```

Exiting on failure:

```
{ ~/.bin/egit -p || ~/.bin/egit -n && exit 1; } && ~/.bin/sgitt_auto
```
