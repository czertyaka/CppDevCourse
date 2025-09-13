#include <iostream>

void foo(int x) {
    std::cout << "&x="
        << &x << std::endl;
    x = -1;
}

int main() {
    int x { 1 };
    std::cout << "&x="
        << &x << std::endl;
    foo(x);
    std::cout << "x="
        << x << std::endl;
}
