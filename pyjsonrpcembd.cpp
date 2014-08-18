// cc  -fPIC -Wall -g -c  -I/usr/include/python2.5 pyjsonrpcembd.cpp 
// cc -I/usr/include/python2.5 -g  -shared -Wl,-soname,libjsonrpcembd.so.0   -o libpyjsonrpcembd.so.0.0   pyjsonrpcembd.o  -lpython2.5 -lboost_python
// ln -sf libpyjsonrpcembd.so.0 libpyjsonrpcembd.so


//cc -I/usr/include/python2.5 -g  -shared -Wall -fPIC -o libjsonrpcembd.so   pyjsonrpcembd.o

#include <string>
#include <iostream>
#include <stdio.h>
#include <boost/python.hpp>
//some code copy from pyshake/PythonPlugin.cpp
using namespace std;
using namespace boost::python;
static boost::python::object pyMainModule;
static boost::python::object pyMainNamespace;
template <class T>
T evalPythonExpr(const char *expr)
{
    T retVal = 0;
    try
    {
        object result((handle<>(
                           PyRun_String(expr,
                                        Py_eval_input,
					pyMainNamespace.ptr(),
					pyMainNamespace.ptr()))
                       ));
        retVal = extract<T>(result);
    }
    catch (error_already_set)
    {
        PyErr_Print();
    }
    return retVal;
}

extern "C"
{
     const char *pyEvalExprAsString(const char *expr)
    {
        return evalPythonExpr<const char *>(expr);
    }  
  const char *pyjsonrpcembdhandle(const char *jsonstr)
  {
    //static std::string pyexpr= "server.handle('";
    //pyjsonrpcembd.pyjsonrpcregister.server.handle('{"jsonrpc": "2.0", "method": "echo", "params": ["hello world"], "id": 0}')
    std::string pyexpr= "pyjsonrpcembd.pyjsonrpcregister.server.handle('";    
    pyexpr.append(jsonstr);
    pyexpr.append("')\n");
    return pyEvalExprAsString(pyexpr.c_str());
  }


  void pyjsonrpcembdinit()
  {
    if ( ! Py_IsInitialized() )
        {
            Py_Initialize();
            PyEval_InitThreads();
            try
            {
                pyMainModule = object(handle<>(borrowed(PyImport_AddModule("__main__"))));
                pyMainNamespace = pyMainModule.attr("__dict__");
            }
            catch (error_already_set)
            {
                PyErr_Print();
            }
         }
    PyRun_SimpleString("import pyjsonrpcembd");    
    //FILE *fp      = fopen ("pyjsonrpcregister.py",   "r+");
    //PyRun_SimpleFile(fp, "pyjsonrpcregister.py");
  }

  void pyjsonrpcembdfinalize()
  {
    Py_Finalize();
  }
}
