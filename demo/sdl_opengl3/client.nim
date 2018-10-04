import net

<<<<<<< HEAD
const ipv6Address = "2002:6fdd:f3f6:0:fd62:101:a804:5b99"
const ipv4Address = "120.77.248.64"
var socket = dial(ipv6Address, Port(1234))
socket.send("hello\r\L")
socket.close
    
=======
const ipv6Address = "2002:6fdd:f3f6:0:601c:9fdc:b981:3e7a"

if isIpAddress(ipv6Address):
    var socket = dial(ipv6Address, Port(1234))
    defer: socket.close
    socket.send("hello")
    
>>>>>>> 84a8300ced88f4e590acc8ef4181b4f98a6c15c9
