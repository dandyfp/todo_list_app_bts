import 'package:flutter/material.dart';

Map<double, SizedBox> _verticalSpaces = {};
Map<double, SizedBox> _horizontalSpaces = {};

SizedBox verticalSpace(double height) {
  if (!_verticalSpaces.containsKey(height)) {
    _verticalSpaces[height] = SizedBox(
      height: height,
    );
  }
  return _verticalSpaces[height]!;
}

SizedBox horizontalSpace(double widht) {
  if (!_horizontalSpaces.containsKey(widht)) {
    _horizontalSpaces[widht] = SizedBox(
      width: widht,
    );
  }
  return _horizontalSpaces[widht]!;
}

String capitalizeEachWord(String input) {
  return input.split(' ').map((word) {
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
