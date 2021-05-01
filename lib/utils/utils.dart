import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const String CLIENT_BASE_KEY = "CLIENT_BASE_KEY";

var phoneFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
