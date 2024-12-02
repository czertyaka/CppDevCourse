#include <iostream>

struct Point {
    double x;
    double y;
    double z;
};

int main() {
    Point p {};
    using namespace std;
    cout << &p << '\n';
    cout << sizeof(p) << '\n';
    cout << &p.x << '\n';
    cout << &p.y << '\n';
    cout << &p.z << '\n';
}
