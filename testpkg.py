import pyjsonrpcembd
pyjsonrpcembd.pyjsonrpcregister.server.handle('{"jsonrpc": "2.0", "method": "echo", "params": ["hello world"], "id": 0}')

#server = pyjsonrpcembd.jsonrpc.Server( pyjsonrpcembd.jsonrpc.JsonRpc20(), pyjsonrpcembd.jsonrpc.TransportSTDINOUT())
