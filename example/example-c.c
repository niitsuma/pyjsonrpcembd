#include <stdio.h>
#include "../pyjsonrpcembd.h"

int main()
{
    pyjsonrpcembdinit();

    PyRun_SimpleString("print(sorted([5,2,4,3]))");


    printf(pyjsonrpcembdstreval("sorted([5,2,4,3])"));//[2, 3, 4, 5]
    printf("\n");
    printf(pyjsonrpcembdhandle("{\"method\": \"sorted\", \"params\": [[5,2,4,3]]}")); //[2, 3, 4, 5]
    printf("\n");
    printf(pyjsonrpcembdstreval("_"));//[2, 3, 4, 5]
    printf("\n");

    printf(pyjsonrpcembdstreval("round(1.2345,2)"));//1.23
    printf("\n");
    printf(pyjsonrpcembdhandle("{\"method\": \"round\", \"params\": [1.2345,2]}")); //1.23
    printf("\n");


    printf(pyjsonrpcembdhandle("{\"method\": \"min\", \"params\": [[9,3,7]]}"));//3
    printf("\n");

    printf(pyjsonrpcembdstreval("3*4")); //12
    printf("\n");
    printf(pyjsonrpcembdstreval("str(12)")); //"12"
    printf("\n");
    printf(pyjsonrpcembdhandle("{\"method\": \"str\", \"params\": [12]}")); //"12"
    printf("\n");


    pyjsonrpcembdstrexec("x=[2,6]");
    printf(pyjsonrpcembdstreval("x*2")); //[2, 6, 2, 6]
    printf("\n");

    pyjsonrpcembdstrexec("import sys");
    pyjsonrpcembdstrexec         ("setattr(sys.modules[__name__], \"y\", 323)");
    //printf(pyjsonrpcembdstreval("setattr(sys.modules[__name__], \"y\", 323)"));
    printf(pyjsonrpcembdstreval("y"));//323
    printf("\n");
    //pyjsonrpcembdstrexec("z=_"); //not implemented 


    pyjsonrpcembdstrexec("import numpy");
    printf(pyjsonrpcembdstreval("numpy.linalg.norm([1,2])")); //2.2360679774997898
    printf("\n");
    printf(pyjsonrpcembdhandle("{\"method\": \"numpy.linalg.norm\", \"params\": [[1,2]]}")); 
    printf("\n");

    
    //Py_Finalize(); // bug python3 http://stackoverflow.com/questions/8798905/does-the-python-3-interpreter-leak-memory-when-embedded
    //work with python2.7
    return 0;
}
