#include <iostream>

unsigned int get_number();

int main() {
    const int x = get_number();
    std::cout << x << std::endl;
}
