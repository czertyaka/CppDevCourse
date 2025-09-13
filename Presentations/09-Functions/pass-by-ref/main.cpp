#include <iostream>

void foo(int* p) {
    std::cout << "&p="
        << &p << std::endl;
    *p = -1;
}

int main() {
    int x { 1 };
    int* p { &x };
    std::cout << "&p="
        << &p << std::endl;
    foo(p);
    std::cout << "x="
        << x << std::endl;
}
