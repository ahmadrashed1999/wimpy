// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyClass {
  static int myVar = 0;
  int myInstanceVar;

  MyClass(
    this.myInstanceVar,
  ) {
    myVar++;
    myInstanceVar = myVar;
  }
}
