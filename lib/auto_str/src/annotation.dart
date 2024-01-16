/// Annotation for classes as top-level annotation.
///
/// Generate an extension that provides `toString` override for this class.
///
/// All marked classes will be scanned for `toString` result formats.
///
class AutoStr {
  const AutoStr();
}

/// Annotation for class fields as attribute annotation for specified field.
class StrAttr {
  const StrAttr({
    this.name,
    this.value,
    this.ignore = false,
    this.asInstance = false,
  });

  /// Field name in debug message.
  final String? name;

  // TODO: Support wrapping actual value.
  /// Field value in debug message.
  ///
  /// Override actual field value.
  final String? value;

  /// Ignore this field when converting to string.
  ///
  /// Set default to `false`.
  ///
  /// Conflict with `asInstance`.
  final bool ignore;

  /// Only show `Instance of 'xxx'` in conversion.
  ///
  /// Set default to `false`.
  ///
  /// Conflict with `ignore`.
  final bool asInstance;
}
