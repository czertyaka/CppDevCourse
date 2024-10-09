#include <iostream>

// print Value and Comma
#define VC(X) X << ", "

int main() {
    std::cout
        << VC(1)
        << VC(3.14)
        << "text"
        << std::endl;
}
