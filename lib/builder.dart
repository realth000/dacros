import 'package:build/build.dart';
import 'package:dacros/auto_str/auto_str.dart';
import 'package:source_gen/source_gen.dart';

Builder autoStrBuilder(BuilderOptions options) {
  return SharedPartBuilder([AutoStrGenerator(options)], 'auto_str');
}
