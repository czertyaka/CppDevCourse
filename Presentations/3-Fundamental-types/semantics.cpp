#include <iostream>
#include <cstdint>

int main() {
    bool  b = 0x41;
    short s = 0x41;
    char  c = 0x41;
    std::cout << "b=" << b << ", " << "s=" << s << ", "
        << "c=" << c << std::endl;
}
