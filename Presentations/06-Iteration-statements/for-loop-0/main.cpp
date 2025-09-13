#include <iostream>

int main() {
    for (unsigned i = 0; i < 3; i = i + 1) {
        std::cout << "Number of this iteration is "
            << i << std::endl;
    }
}
