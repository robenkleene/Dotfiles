- `ssh -t user@hostname /bin/bash`: Login while specifying full path to shell

# Troubleshooting

If they `Enter passphrase for key:` prompt keeps happening, even after entering passphrase try running:

```
eval `ssh-agent -s`
ssh-add -l
```
