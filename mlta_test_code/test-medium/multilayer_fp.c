#include <stdio.h>

typedef void (*f_ptr)(int a, int b);

void add(int a, int b) {
    printf("Addition: %d + %d = %d\n", a, b, a + b);
}

void subtract(int a, int b) {
    printf("Subtraction: %d - %d = %d\n", a, b, a - b);
}

struct Inner {
    f_ptr func1;
    f_ptr func2;
};

int main() {
    struct Inner operations = { .func1 = add, .func2 = subtract };

    operations.func1(10, 5); // Calls add
    operations.func2(10, 5); // Calls subtract

    return 0;
}
