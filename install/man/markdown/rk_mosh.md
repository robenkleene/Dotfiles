- `^^.` (Control-^ then .): Quit, note that in Blink Shell, the `^` above the keyboard in the accessory view does not work, you need to hit the version in the keyboard.
- Kill server with `pkill mosh-server` (this will of course kill your connection, but you should be able to reconnect again immediately)

# Troubleshooting

## Troubling Connecting to Server

```
pkill mosh-server
```

If the client connects then exits (e.g., )

```
mosh did not make a successful connection to 192.241.150.148:60001.
Please verify that UDP port 60001 is not firewalled and can reach the server.

(By default, mosh uses a UDP port between 60000 and 61000. The -p option
selects a specific UDP port number.)
[mosh is exiting.]
```

From the client, make sure the port is open (e.g., `6001` below)

```
$ sudo ufw status verbose 

Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
2022                       ALLOW IN    Anywhere                  
22/tcp (OpenSSH)           ALLOW IN    Anywhere                  
60001/udp                  ALLOW IN    Anywhere                  
2022 (v6)                  ALLOW IN    Anywhere (v6)             
22/tcp (OpenSSH (v6))      ALLOW IN    Anywhere (v6)             
60001/udp (v6)             ALLOW IN    Anywhere (v6)
```

If it's not open, use `sudo ufw allow 60001/udp` to open it.

## Trouble With Local Client

E.g., `Library not loaded` with Homebrew version

```
brew reinstall mosh
```
