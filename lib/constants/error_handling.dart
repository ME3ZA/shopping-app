import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/constants/utils.dart';

void httpErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      ShowSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      ShowSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      ShowSnackBar(context, response.body);
  }
}
