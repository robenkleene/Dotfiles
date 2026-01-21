# Long Polling

Long polling is an alternative to web sockets.

Long polling just means sending a request to the server, then the server doesn't respond to that request until it has an update. After the update is received on the client side, the client then immediately sends another request awaiting the next update.
