#include <iostream>

int main() {
    int arr[] = {1, 2};
    std::cout << "arr[0]=" << arr[0] << std::endl;
    std::cout << "arr[1]=" << arr[1] << std::endl;
    arr[1] = -1;
    std::cout << "arr[1]=" << arr[1] << std::endl;
}
