import 'package:example/example.dart' as example;

void main(List<String> arguments) {
  final foo = example.Foo<int>(1, 'hello dacros');
  print('$foo');
}
