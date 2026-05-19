- `<hostname>` can always also be `<user>@<hostname>`
- `-t`: Force pseudo terminal
- `ssh -t <hostname> /bin/bash`: Login while specifying full path to shell
- `ssh <hostname> <cmd>`: This supports piping, e.g., `ssh <hostname> echo 'foo' | tmux loadb -` or `echo 'foo' | ssh <hostname> tmux saveb -`

# Troubleshooting

If they `Enter passphrase for key:` prompt keeps happening, even after entering passphrase try running:

```
eval `ssh-agent -s`
ssh-add -l
```
