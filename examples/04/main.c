#define export __attribute__((visibility("default")))

#include <stdio.h>

export void say_hello() {
  printf("Hello World!\n");
}
