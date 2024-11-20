#include <iostream>

int main() {
    int arr[] = {1, 2, 3};
    std::cout << "sizeof(int)=" << sizeof(int) << std::endl;
    std::cout << "sizeof(arr[0])=" << sizeof(arr[0])
        << std::endl;
    std::cout << "sizeof(arr)=" << sizeof(arr) << std::endl;
}
