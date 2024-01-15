// https://stackoverflow.com/questions/67842208/can-mixins-access-the-state-of-the-class-theyre-mixed-with-in-dart

import 'package:dacros/auto_src/auto_str.dart';

extension FooAutoStr on Foo {
  String autoStr(Foo foo) {
    return 'enhanced! ${foo.bar}';
  }
}

/////////////////////////////////////////////

@AutoStr()
class Foo {
  const Foo(this.bar, this.baz);

  final int bar;

  final int baz;

  @override
  String toString() => autoStr(this);
}

void main() {
  final foo = Foo(1, 200);

  print('>>> "${foo.toString()}"');
}
