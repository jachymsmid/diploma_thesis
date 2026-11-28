#pragma once

#include <functional>
#include <iostream>
#include <vector>

struct InitialCondition {
  float point;
  float value;
};

template <class RealNumber = float> struct Euler {

  // todo: initializer
  Euler(std::vector<RealNumber> &data_) : data(data_) {};

  // integration step
  RealNumber step;

  // integration final time
  RealNumber end_time;

  // data object
  std::vector<RealNumber> &data;

  // initial condition
  InitialCondition initial_condition;

  // rhs function
  std::function<RealNumber(RealNumber, RealNumber)> rhs;

  void solve() {

#if DEBUG
    std::cout << "Initialized the Euler solver with:\n\t"
                 "step: "
              << step
              << "\n\t"
                 "initial condition: "
              << initial_condition.value
              << "\n\t"
                 "data size: "
              << data.size() << '\n';
#endif

    data[0] = initial_condition.value;
    float t = 0;

#if OPENMP
#pragma omp parallel for
#endif
    for (int i = 1; i < data.size(); i++) {
      data[i] = data[i - 1] + step * rhs(t, data[i - 1]);
      t += step;
    }
  }
};
