#define export __attribute__((visibility("default")))

#include <stdio.h>

export void print(char* string) {
  printf("String: '%s'\n", string);
}
