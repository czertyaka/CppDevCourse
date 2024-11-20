int main() {
    foo(); // compilation error
}

void foo();

void bar() {
    foo(); // ok
}
