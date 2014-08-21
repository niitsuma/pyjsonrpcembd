#include <stdio.h>
#include "../pyjsonrpcembd.h"

int main()
{
    pyjsonrpcembdinit();

    PyRun_SimpleString("print(3*4)");
    printf("\n");
    printf(pyjsonrpcembdhandle
	   ("{\"jsonrpc\": \"2.0\", \"method\": \"min\", \"params\": [[9, 3,7]], \"id\": 0}"));
    printf("\n");
    printf(pyjsonrpcembdhandle("{\"method\": \"min\", \"params\": [[9, 3,7]]}"));
    printf("\n");
    printf(pyjsonrpcembdhandle("{\"method\": \"range\", \"params\": [2,6]}")); //[2, 3, 4, 5]
    printf("\n");
    pyjsonrpcembdstrexec("x=[2,6]");
    printf(pyjsonrpcembdstreval("x*2")); //[2, 6, 2, 6]
    printf("\n");
    pyjsonrpcembdstrexec("import sys");
    pyjsonrpcembdstrexec         ("setattr(sys.modules[__name__], \"y\", 323)");
    //printf(pyjsonrpcembdstreval("setattr(sys.modules[__name__], \"y\", 323)"));
    printf(pyjsonrpcembdstreval("y"));//323
    printf("\n");
    printf(pyjsonrpcembdstreval("_"));//323
    printf("\n");
    //pyjsonrpcembdstrexec("z=_"); //not implemented 
    //printf(pyjsonrpcembdhandle("{\"method\": \"setattr\", \"params\": [sys.modules[__name__], \"y\", 424]}"));
    Py_Finalize();
    return 0;
}