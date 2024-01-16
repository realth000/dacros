import 'package:dacros/auto_str/auto_str.dart';

part 'example.g.dart';

class OtherAnnotation {
  const OtherAnnotation();
}

@AutoStr()
class Foo<T> {
  Foo(
    this.i,
    this.s, {
    this.tList = const [],
    this.testStrAttr1 = '',
    this.testStrAttr2 = '',
    this.testStrAttr3 = '',
    this.testStrAttr4 = 0,
    this.testStrAttr5 = 1,
    this.testStrAttr6 = const OtherAnnotation(),
  });

  final int i;

  String? _j;

  /// Test for getter
  String? get getJ => _j;

  /// Test for setter
  set setJ(String v) => _j = v;

  /// Test for functions.
  int testFunction() => 0;

  /// Test for generic fields.
  T? t;

  List<T> tList;

  @OtherAnnotation()
  String s;

  @StrAttr()
  String testStrAttr1;

  @StrAttr(name: 'attr2')
  String testStrAttr2;

  @StrAttr(value: 'attr3value')
  String testStrAttr3;

  @StrAttr(ignore: true)
  int testStrAttr4;

  @StrAttr(asInstance: true)
  int testStrAttr5;

  @StrAttr(
    name: 'attr6',
    value: 'attr6value',
    ignore: false,
    asInstance: false,
  )
  OtherAnnotation? testStrAttr6;

  @override
  String toString() => _autoStr(this);
}
