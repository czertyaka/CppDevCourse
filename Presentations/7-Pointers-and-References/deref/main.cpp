#include <iostream>

int main() {
    const double d = 3.14;
    const double* p = &d;

    std::cout << "d=" << d << std::endl;
    std::cout << "*p=" << *p << std::endl;
}
