import net

const ipv6Address = "2002:6fdd:f3f6:0:601c:9fdc:b981:3e7a"

if isIpAddress(ipv6Address):
    var socket = dial(ipv6Address, Port(1234))
    defer: socket.close
    socket.send("hello")
    
