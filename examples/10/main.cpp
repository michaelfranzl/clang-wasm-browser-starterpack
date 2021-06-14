#define export __attribute__((visibility("default")))

extern "C" export int add (int lhs, int rhs) {
  return lhs + rhs;
}
