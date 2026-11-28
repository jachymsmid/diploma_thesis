#include "solvers.h"
#include <iostream>

int main() {

   // todo: cli arguments handler
   //  - --graph : execute a python script
   //  - --o 'string' : path to output dir 
   //  - --parallel : execute with openmp
   //  - --cores : number of cores for parallel computation
   //  - --test : test convergence

   // --
   // define parameters
   // --

  constexpr float value = 2.0F;
  constexpr float point = 0.0F;

  // do I need end time? the data vector is supplied, so I know its size
  // but what if the supplied data object doesnt implement .size()?
  constexpr float T = 1.0F;
  constexpr float h = 0.01;

  std::vector<float> data(100);

  // --
  // define the solver
  // --

  Euler<float> euler_solver(data);
  euler_solver.initial_condition.point = point;
  euler_solver.initial_condition.value = value;
  euler_solver.step = h;
  euler_solver.end_time = T;
  euler_solver.rhs = [](float t, float x) { return t; };

  // --
  // solve the problem
  // --

  euler_solver.solve();

  // --
  // output
  // --

  for (int i = 0; i < data.size(); i++) {
    std::cout << data[i] << '\n';
  }

  return 0;
}
