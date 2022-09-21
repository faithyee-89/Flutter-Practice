import 'package:cainiaowo/utils/regex/regex_utils.dart';
import 'package:formz/formz.dart';

// enum MobileValidationError { empty, error }

class MobileValidation extends FormzInput<String, String> {
  const MobileValidation.pure() : super.pure('');
  const MobileValidation.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) return "手机号不能为空";

    if (!RegexUtils.isMobileExact(value)) return "手机号格式错误";
  }
}
