import asyncnet, asyncdispatch

var clients {.threadvar.}: seq[AsyncSocket]

proc listen() {.async.} = 
  proc processClient(client: AsyncSocket) {.async.} =
    while true:
      let line = await client.recv(256)
      echo line
      if line.len == 0: break
      for c in clients:
        await c.send(line & "\c\L")

  proc serve() {.async.} =
    clients = @[]
    var server = newAsyncSocket()
    defer: server.close()
    server.setSockOpt(OptReuseAddr, true)
    server.bindAddr(Port(1234))
    server.listen()
    var client : AsyncSocket
    var address: string
    while true:
      let (address, client) = await server.acceptAddr()
      echo address
      clients.add client
      asyncCheck processClient(client)

  asyncCheck serve()
  runForever()
asyncCheck listen()