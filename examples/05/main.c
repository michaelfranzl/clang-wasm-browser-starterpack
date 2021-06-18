#define export __attribute__((visibility("default")))

export char* say() {
  return "Hello World! 😀";
}
