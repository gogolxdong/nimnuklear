import net, threadpool

const ipv6Address = "2002:6fdd:f3f6:0:51b:68ce:288a:7602"

if isIpAddress(ipv6Address):
    var socket = dial(ipv6Address, Port(1234))
    defer: socket.close
    socket.send("hello")
    
proc recv(socket: Socket) =
    var line = socket.recvLine()
    echo line