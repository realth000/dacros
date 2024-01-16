import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dacros/auto_str/auto_str.dart';
import 'package:source_gen/source_gen.dart';

class AutoStrGenerator extends GeneratorForAnnotation<AutoStr> {
  AutoStrGenerator(this.options);

  /// Record the location of annotation [StrAttr] to filter fields attributes.
  static const _strAttrLocation = 'package:dacros/auto_str/src/annotation.dart';

  final BuilderOptions options;

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final stringPart = <String>[];

    // final name = annotation.read('name').literalValue as String?;
    // print(element.children);
    for (final field in element.children) {
      // Only check annotations for field types.
      //
      // This means:
      // * Constructors and methods will be ignored.
      // * Getters and setters will be ignored.
      //
      // Some fields are not directly owned by the original source code.
      // For example a getter/setter will hold extra `field` with same name and type.
      // These fields should be excluded from analyze.
      // Use `isSynthetic` to filter out them.
      if (field.kind != ElementKind.FIELD || field.isSynthetic) {
        continue;
      }
      // print('>>> field: $field, ${field.metadata}');

      final f = field as FieldElement;

      bool hasStrAttr = false;

      for (final anno in field.metadata) {
        /// Filter out non [StrAttr] annotations.
        if (anno.element?.location?.components.firstOrNull !=
            _strAttrLocation) {
          continue;
        }
        final annoFieldValue = anno.computeConstantValue();
        if (annoFieldValue == null) {
          continue;
        }

        // Check attributes in `StrAttr`.

        final name = annoFieldValue.getField('name')?.toStringValue();
        final value = annoFieldValue.getField('value')?.toStringValue();
        final ignore = annoFieldValue.getField('ignore')?.toBoolValue();
        final asInstance = annoFieldValue.getField('asInstance')?.toBoolValue();

        // print('>>> ${f.name}: ${name}, ${value}, ${ignore} ${asInstance}');

        // Ignore current field if ignore is true.
        if (ignore == true) {
          continue;
        }

        if (asInstance == true) {
          stringPart.add("${name ?? f.name}=Instance of '${f.type}'");
          continue;
        }

        stringPart.add('${name ?? f.name}=${value ?? "\$${f.name}"}');
        hasStrAttr = true;
        break;
      }

      if (!hasStrAttr) {
        stringPart.add('${f.name}=\$${f.name}');
      }
    }

    final contents = stringPart.map((e) => '  $e').join('\n');

    final name = (element as ClassElement).name;

    final result = '''
extension _${name}AutoStr on ${name} {
  String _autoStr(${name} v) {
    return \'\'\'
${name} {
${contents}
}
\'\'\';
  }
}
''';
    // print(result);
    return result;
  }
}
