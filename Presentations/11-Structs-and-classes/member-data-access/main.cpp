#include <iostream>
#include "complex_number.hpp"

void print(const ComplexNumber* const x) {
    std::cout << x->real // оператор member of pointer
        << (x->imaginary > 0 ? "+" : "")
        << x->imaginary << 'i'
        << std::endl;
}

int main() {
    ComplexNumber z {1.0, 2.0};
    z.real = -1.0; // оператор member of object
    print(&z);
}
