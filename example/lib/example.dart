import 'package:dacros/auto_str/auto_str.dart';

part 'example.g.dart';

@AutoStr()
class Foo {
  Foo(this.i, this.i3, this.decoratedString);

  final int i;

  /// Ignored.
  @StrAttr(ignore: true)
  final int i3;

  @StrAttr(asInstance: true)
  int? i2;

  @StrAttr(name: 'SpecifiedName')
  String? decoratedString;

  @override
  String toString() => _autoStr(this);
}
