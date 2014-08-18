// cc -Wall -g -c calltest.c -o calltest.o
// cc -g -o calltest calltest.o -L. -lpyjsonrpcembd



// cc -g calltest.c  -L.  -lpyjsonrpcembd


////cc calltest.c -I/usr/include/python2.5 -lpython2.5 -lboost_python -lpyjsonrpcembd -Wall -L

#include <stdio.h>

#if 1
const char *pyjsonrpcembdhandle(const char *jsonstr);
void pyjsonrpcembdinit();
#else
#include "pyjsonrpcembd.h"
#endif

int main()
{
    pyjsonrpcembdinit();
    printf(
	    pyjsonrpcembdhandle
	    ("{\"jsonrpc\": \"2.0\", \"method\": \"norm\", \"params\": [[2, 3]], \"id\": 0}"));
    
    printf(
	    pyjsonrpcembdhandle
	    ("{\"jsonrpc\": \"2.0\", \"method\": \"echo\", \"params\": [[2, 3]], \"id\": 0}"));   
   Py_Finalize();
   return 0;
}
