#include <string>
#include <iostream>
#include <stdio.h>
//#include <string.h>
#include <boost/python.hpp>
#include <boost/algorithm/string.hpp> 

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
    std::string jsonstr1(jsonstr0.c_str(), jsonstr0.length());
    boost::replace_all(jsonstr1, "\"", "\\\"");
    std::string eval_json_loads_all_str="str(json.loads(\""+jsonstr1+"\"))";
    std::string eval_json_loads_method_str="str(json.loads(\""+jsonstr1+"\")['method'])";
    object method_obj = eval(eval_json_loads_method_str.c_str() ,py_main_namespace);
    std::string method_str=extract<std::string>(method_obj);
#if 0
    std::string eval_result_str="json.dumps(apply(" +method_str  +  ",json.loads(\""+jsonstr1+"\")['params']))";
    object result_json_obj = eval(eval_result_str.c_str() ,py_main_namespace);
#else
    std::string eval_result_str="apply(" +method_str  +  ",json.loads(\""+jsonstr1+"\")['params'])";
    py_result = eval(eval_result_str.c_str() ,py_main_namespace);
    //object result_json_obj=py_main_module.attr("json.dumps")(py_result);
    object result_json_obj=(py_main_module.attr("json").attr("dumps"))(py_result);
#endif
    std::string result_json_str=extract<std::string>(result_json_obj); 
    return result_json_str.c_str();
  }


  const char *pyjsonrpcembdstreval(const char *expression)
  {
    std::string s(expression); 
    object result_json_obj;
    if(s.compare("_") != 0){
#if 0
	std::string eval_result_str="json.dumps(" + s  + ")";
	result_json_obj = eval(eval_result_str.c_str() ,py_main_namespace);
#else
	py_result  = eval(s.c_str() ,py_main_namespace);
#endif
      }
    result_json_obj=(py_main_module.attr("json").attr("dumps"))(py_result);
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

