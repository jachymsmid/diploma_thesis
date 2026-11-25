#pragma once

#include <functional>
#include <iostream>
#include <vector>

struct InitialCondition {
  float point;
  float value;
};

std::vector<float>
euler( float step, float end_time,
      InitialCondition initial_condition,
      std::function<float(float, float)> rhs)
{
   std::vector<float> data((int)end_time/step);
   data[0] = initial_condition.value;
   float t = 0;

   for (int i = 1; i < data.size(); i++)
   {
      data[i] = data[i-1] + step * rhs(t, data[i-1]);
      t += step;
   }

   return data;
}
