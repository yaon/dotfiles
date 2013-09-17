#include <iostream>

static void prettyfact(int n)
{
  if (n == 1)
    throw 1;
  try
  {
    prettyfact (n - 1);
  }
  catch (int i)
  {
    throw i * n;
  }
}

int fact (int n)
{
  try
  {
    prettyfact (n);
  }
  catch (int ret)
  {
    return ret;
  }
  return 0;
}
