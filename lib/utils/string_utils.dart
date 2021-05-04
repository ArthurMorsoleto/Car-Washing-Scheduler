import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Strings
const String CLIENT_BASE_KEY = "CLIENT_BASE_KEY";
const String WASH_SERVICE_LIST_KEY = "WASH_SERVICE_LIST_KEY";

// String utils
var phoneFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
