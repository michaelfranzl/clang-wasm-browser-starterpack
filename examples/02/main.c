#define export __attribute__((visibility("default")))

float square(float x);
float square_root(float x);

export float hypotenuse(float a, float b) {
  return square_root(square(a) + square(b));
}
