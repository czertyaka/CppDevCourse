#include <iostream>

void foo(const double d) {
    const short c = d;
    std::cout << c
     << std::endl;
}

int main() {
    foo(1.0); // ok
    // information loss
    foo(1.1);
    // information loss
    foo(70000.0);
}
