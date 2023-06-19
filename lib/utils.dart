import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildDateTimeText(
    {String? text = '', required DateTime dateTime, TextStyle? style}) {
  return Text(
    '$text ${DateFormat('yyyy-MM-dd HH:mm').format(dateTime)}',
    style: style,
  );
}
