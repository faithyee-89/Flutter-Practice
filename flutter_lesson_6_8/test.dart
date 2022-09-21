void main() {
  double a = 1.0;
  if (a is num) {
    print("a is num");
  }

  if (a is int) {
    print("a is int");
  }

  if (a is double) {
    print("a is double");
  }
}
