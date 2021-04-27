#define export __attribute__((visibility("default")))

export int add(int left, int right) {
  return left + right;
}
