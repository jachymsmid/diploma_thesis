#include "solvers.h"
#include <iostream>

int main() {

  InitialCondition ic;
  ic.value = 1.0F;
  ic.point = 0.0F;

  float T = 1.0F;
  float h = 0.01;

  std::vector<float> data = euler(h, T, ic, [](float x, float y) -> float{return x;});

  for (int i = 0; i < data.size(); i++) {
     std::cout << data[i] << '\n';
  }

  return 0;
}
