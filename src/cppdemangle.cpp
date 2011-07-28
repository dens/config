#include <iostream>
#include <cstring>
#include <cstdlib>
#include <cxxabi.h>
using namespace std;

int
cppdemangle (const char* mangledname, std::string& ret)
{
  int status;
  char* buf (abi::__cxa_demangle (mangledname, 0, 0, &status));
  if (!buf)
  {
    switch (status)
      {
      case  0: ret = "The demangling operation succeeded"; break;
      case -1: ret = "A memory allocation failure occurred"; break;
      case -2: ret = "NAME is not a valid name under the C++ ABI mangling rules"; break;
      case -3: ret = "One of the arguments is invalid"; break;
      }
    return status;
  }
  ret = buf;
  free (buf);
  return 0;
}

int
main (int argc, char** argv)
{
  if (argc != 2)
    {
      cerr << "usage: " << argv[0] << " NAME" << endl;
      return 1;
    }
  std::string ret;
  int status (cppdemangle (argv[1], ret));
  if (status != 0)
    {
      cerr << "Error (" << status << "): " << ret << endl;
      return 2;
    }
  cout << ret << endl;
  return 0;
}
