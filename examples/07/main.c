#define export __attribute__((visibility("default")))

#include <stdio.h>

export int main (int argc, char* argv[]) {
  for (int i = 0; i < argc; i++)
    printf("Argv %i: '%s'\n", i, argv[i]);
}
