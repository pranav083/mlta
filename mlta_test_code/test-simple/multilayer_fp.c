#include <stdio.h>

// Typedef for a function pointer
typedef void (*f_ptr)(int a, int b);

// Define a deeply nested structure with function pointers
struct InnerMost {
    f_ptr func;
};

struct Inner {
    struct InnerMost im1;
    struct InnerMost im2;
};

struct Middle {
    struct Inner in1;
    struct Inner in2;
};

struct Outer {
    struct Middle m1;
    struct Middle m2;
};

// Functions to be used as callbacks
void func_x(int a, int b) {
    printf("func_x: a=%d, b=%d\n", a, b);
}

void func_y(int a, int b) {
    printf("func_y: a=%d, b=%d\n", a, b);
}

void func_z(int a, int b) {
    printf("func_z: a=%d, b=%d\n", a, b);
}

void func_w(int a, int b) {
    printf("func_w: a=%d, b=%d\n", a, b);
}

void func_p(int a, int b) {
    printf("func_p: a=%d, b=%d\n", a, b);
}

void func_q(int a, int b) {
    printf("func_q: a=%d, b=%d\n", a, b);
}

void func_r(int a, int b) {
    printf("func_r: a=%d, b=%d\n", a, b);
}

void func_s(int a, int b) {
    printf("func_s: a=%d, b=%d\n", a, b);
}

int main() {
    // Initialize the deeply nested structure
    struct Outer s1 = {
        .m1 = {
            .in1 = { .im1 = { .func = func_x }, .im2 = { .func = func_y } },
            .in2 = { .im1 = { .func = func_z }, .im2 = { .func = func_w } },
        },
        .m2 = {
            .in1 = { .im1 = { .func = func_p }, .im2 = { .func = func_q } },
            .in2 = { .im1 = { .func = func_r }, .im2 = { .func = func_s } },
        }
    };

    // Multilayer indirect calls
    s1.m1.in1.im1.func(10, 20); // Calls func_x
    s1.m1.in1.im2.func(30, 40); // Calls func_y
    s1.m1.in2.im1.func(50, 60); // Calls func_z
    s1.m1.in2.im2.func(70, 80); // Calls func_w

    s1.m2.in1.im1.func(15, 25); // Calls func_p
    s1.m2.in1.im2.func(35, 45); // Calls func_q
    s1.m2.in2.im1.func(55, 65); // Calls func_r
    s1.m2.in2.im2.func(75, 85); // Calls func_s

    return 0;
}
