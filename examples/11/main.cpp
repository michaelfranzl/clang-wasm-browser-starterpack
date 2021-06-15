#define export __attribute__((visibility("default")))

#include <iostream>
#include <vector>

extern "C" export void test() {
    std::vector<int> vect;
    vect.push_back(1);
    vect.push_back(5);
    vect.push_back(7);
    std::cout << "The second element in the vector is " << vect[1] << std::endl;
}
