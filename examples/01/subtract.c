#define export __attribute__((visibility("default")))

export int subtract(int left, int right) {
  return left - right;
}
