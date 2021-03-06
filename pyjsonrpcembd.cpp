#include <string>
#include <iostream>
#include <stdio.h>
#include <boost/python.hpp>

using namespace std;
using namespace boost::python;
static boost::python::object py_main_module;
static boost::python::object py_main_namespace;

static boost::python::object py_result;


extern "C"
{
  const char *pyjsonrpcembdhandle(const char *jsonstr)
  {
    std::string jsonstr0(jsonstr);
    std::string eval_json_loads_method_str="str(json.loads('"+jsonstr0+"')['method'])";
    object method_obj = eval(eval_json_loads_method_str.c_str() ,py_main_namespace);
    std::string method_str=extract<std::string>(method_obj);
    std::string eval_result_str="apply(" +method_str  +  ",json.loads('"+jsonstr0+"')['params'])";
    py_result = eval(eval_result_str.c_str() ,py_main_namespace);
    object result_json_obj=(py_main_module.attr("json").attr("dumps"))(py_result);
    std::string result_json_str=extract<std::string>(result_json_obj); 
    return result_json_str.c_str();
  }


  const char *pyjsonrpcembdstreval(const char *expression)
  {
    std::string s(expression); 
    if(s.compare("_") != 0){
	py_result  = eval(s.c_str() ,py_main_namespace);
      }
    object result_json_obj=(py_main_module.attr("json").attr("dumps"))(py_result);
    std::string result_json_str=extract<std::string>(result_json_obj);
    return result_json_str.c_str();
  }

  void pyjsonrpcembdstrexec(const char *statement)
  {
    PyRun_SimpleString(statement);    
  }

  void pyjsonrpcembdinit()
  {
    if ( ! Py_IsInitialized() )
      {
	Py_Initialize();
	PyEval_InitThreads();
	try
	  {
	    py_main_module =  import("__main__");
	    py_main_namespace = py_main_module.attr("__dict__");
	    py_main_namespace["json"] = import("json");
	    py_main_namespace["sys"] = import("sys");

	    object ignored = exec(
				  "if sys.version_info[0] > 2:\n"
				  "\tdef apply(fn,args):\n"
				  "\t\tif len(args) > 1:\n"
				  "\t\t\treturn (fn(*args))\n"
				  "\t\telse:\n"
				  "\t\t\treturn (fn(args[0]))\n"
				  ,
				  py_main_namespace);

	  }
	catch (error_already_set)
	  {
	    PyErr_Print();
	  }
      }
  }

  void pyjsonrpcembdfinalize()
  {
    Py_Finalize();
  }
}

