import 'package:dacros/auto_str/auto_str.dart';
import 'package:test/test.dart';

part 'auto_str_test.g.dart';

@AutoStr()
class Foo001 {
  @override
  String toString() => _autoStr();
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
  String toString() => _autoStr();
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
  String toString() => _autoStr();
}

void test003() {
  test('003-nested-type', () {
    expect(Foo003(Foo002(-1, 'x')).toString(), '''
Foo003 { i=-1, foo=Foo002 { i=-1, s=x, }, }''');
  });
}

//////////////////////////////////////////////////////

@AutoStr()
class Foo004<T> {
  Foo004(this.t);

  T t;

  int? Foo003;

  @override
  String toString() => _autoStr();
}

void test004() {
  test('004-generics', () {
    expect(Foo004<Foo002>(Foo002(100, '200')).toString(), '''
Foo004 { t=Foo002 { i=100, s=200, }, Foo003=Foo003, }''');
  });
}

//////////////////////////////////////////////////////

@AutoStr()
class Foo005 {
  Foo005({
    required this.i,
    required this.j,
    required this.k,
    required this.l,
  });

  final int i;
  final String j;
  final double k;
  final int l;

  @override
  String toString() => _autoStr();
}

void test005() {
  test('005-wrap-line', () {
    expect(Foo005(i: 0, j: '123', k: 1, l: 456).toString(), '''
Foo005 {
  i=0,
  j=123,
  k=1.0,
  l=456,
}''');
  });
}

//////////////////////////////////////////////////////

@AutoStr()
class Foo006 {
  Foo006(
    this.i,
    this.j,
    this.k,
    this.l,
    this.l2,
    this.m,
    this.m2,
  );

  int i;

  @StrAttr(name: 'not j')
  int j;

  @StrAttr(value: 'value-k')
  int k;

  @StrAttr(ignore: true)
  int l;
  @StrAttr(ignore: false)
  int l2;

  @StrAttr(asInstance: true)
  int m;
  @StrAttr(asInstance: false)
  int m2;

  @override
  String toString() => _autoStr();
}

void test006() {
  test('006-StrAttr', () {
    expect(Foo006(1, 2, 3, 4, 5, 6, 7).toString(), '''
Foo006 {
  i=1,
  not j=2,
  k=value-k,
  l2=5,
  m=Instance of \'int\',
  m2=7,
}''');
  });
}

void main() {
  group('AutoStr', () {
    test001();
    test002();
    test003();
    test004();
    test005();
    test006();
  });
}
