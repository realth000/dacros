import 'package:dacros/auto_str/auto_str.dart';
import 'package:test/test.dart';

part 'auto_str_test.g.dart';

@AutoStr()
class Foo001 {
  @override
  String toString() => _autoStr(this);
}

void test001() {
  test('001-basic', () {
    expect(Foo001().toString(), '''Foo001 {}''');
  });
}

//////////////////////////////////////////////////////

@AutoStr()
class Foo002 {
  const Foo002(this.i, this.s);

  final int i;

  final String? s;

  @override
  String toString() => _autoStr(this);
}

void test002() {
  test('002-with-types', () {
    expect(Foo002(10, 'bar').toString(), '''
Foo002 { i=10, s=bar, }''');
  });
}

//////////////////////////////////////////////////////

@AutoStr()
class Foo003 {
  Foo003(this.foo);

  int? i = -1;
  final Foo002 foo;

  @override
  String toString() => _autoStr(this);
}

void test003() {
  test('003-nested-type', () {
    expect(Foo003(Foo002(-1, 'x')).toString(), '''
Foo003 { i=-1, foo=Foo002 { i=-1, s=x, }, }''');
  });
}

void main() {
  group('AutoStr', () {
    test001();
    test002();
    test003();
  });
}
