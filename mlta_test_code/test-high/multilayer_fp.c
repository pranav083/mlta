#include <stdio.h>

// Typedef for a function pointer
typedef void (*f_ptr)(int, int);

// Functions to be used as callbacks
void add(int a, int b) {
    printf("Addition: %d + %d = %d\n", a, b, a + b);
}

void subtract(int a, int b) {
    printf("Subtraction: %d - %d = %d\n", a, b, a - b);
}

void multiply(int a, int b) {
    printf("Multiplication: %d * %d = %d\n", a, b, a * b);
}

void divide(int a, int b) {
    if (b != 0)
        printf("Division: %d / %d = %d\n", a, b, a / b);
    else
        printf("Division by zero error\n");
}

// Define a simple structure with function pointers
struct Operations {
    f_ptr func1;
    f_ptr func2;
};

int main() {
    // Initialize the structure with function pointers
    struct Operations ops = { add, subtract };

    // Call functions through function pointers
    ops.func1(10, 5); // Calls add
    ops.func2(10, 5); // Calls subtract

    // Reassign function pointers
    ops.func1 = multiply;
    ops.func2 = divide;

    ops.func1(10, 5); // Calls multiply
    ops.func2(10, 0); // Calls divide (division by zero error)

    return 0;
}
