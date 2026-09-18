import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDateLabel(DateTime day){
  final now = DateTime.now();

  if(DateUtils.isSameDay(day, now)){
    return "Today";
  }
  final yesterday = now.subtract(const Duration(days: 1));
  if(DateUtils.isSameDay(day, yesterday)){
    return "Yesterday";
  }
  return DateFormat('MMMM d, yyyy').format(day);
}