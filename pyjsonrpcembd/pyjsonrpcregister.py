import pyjsonrpcembd
server = pyjsonrpcembd.jsonrpc.Server( pyjsonrpcembd.jsonrpc.JsonRpc20(), pyjsonrpcembd.jsonrpc.TransportSTDINOUT())

def echo( s ):
    print s
    return s

server.register_function( echo )

import numpy
server.register_function( numpy.linalg.norm )



#server.handle('{"jsonrpc": "2.0", "method": "echo", "params": ["hello world"], "id": 0}')
#server.handle('{"jsonrpc": "2.0", "method": "echo", "params": ["hello world"], "id": 0}')

