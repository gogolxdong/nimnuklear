import asyncnet, asyncdispatch, nativesockets

var clients {.threadvar.}: seq[AsyncSocket]

proc listen() {.async.} = 
  proc processClient(client: AsyncSocket) {.async.} =
    while true:
<<<<<<< HEAD
      let line = await client.recvLine()
=======
      let line = await client.recv(1024)
      echo line
      if line.len == 0: break
>>>>>>> 84a8300ced88f4e590acc8ef4181b4f98a6c15c9
      for c in clients:
        await c.send(line & "\c\L")

  proc serve() {.async.} =
    clients = @[]
    var server = newAsyncSocket(domain = AF_INET6)
    defer: server.close()
    server.setSockOpt(OptReuseAddr, true)
    server.bindAddr(Port(1234))
    server.listen()
    while true:
      let (address, client) = await server.acceptAddr()
      echo address
      clients.add client
      asyncCheck processClient(client)

  asyncCheck serve()
  runForever()
asyncCheck listen()