#include <iostream>

int main() {
    const int* const p {};
    std::cout << *p << std::endl;
}
