(use c-wrapper)
(c-load-library "libpyjsonrpcembd.so")
(c-include "pyjsonrpcembd.h")

(c-load-library "libc")
(c-include "stdio.h")

(pyjsonrpcembdinit)

(printf ( pyjsonrpcembdhandle "{\"jsonrpc\": \"2.0\", \"method\": \"norm\", \"params\": [[2, 3]], \"id\": 0}" ))
(printf ( pyjsonrpcembdhandle "{\"jsonrpc\": \"2.0\", \"method\": \"echo\", \"params\": [\"aaa\"], \"id\": 0}" ))

(pyjsonrpcembdfinalize)