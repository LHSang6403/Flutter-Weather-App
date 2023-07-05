import 'package:flutter/material.dart';

SnackBar snackBarBuilder(String content) {
  return SnackBar(
    content: Text(content),
    action: SnackBarAction(
      label: '',
      onPressed: () {},
    ),
  );
}
