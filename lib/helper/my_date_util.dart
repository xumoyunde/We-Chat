import 'package:flutter/material.dart';

class MyDateUtil {
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final data = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(data).format(context);
  }

  static String getLastMessageTime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    if(now.day == sent.day && now.month == sent.month && now.year == sent.year){
      return TimeOfDay.fromDateTime(sent).format(context);
    }
    return '${sent.day} ${_getMonth(sent)}';
  }

  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Tarmoqda mavjud emas';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Oxirgi marta bugun kirgan: $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Oxirgi marta kecha kirgan: $formattedTime';
    }

    String month = _getMonth(time);

    return 'Oxirgi marta kirgan: ${time.day} $month $formattedTime';
  }

  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Yan';
      case 2:
        return 'Fev';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Iyn';
      case 7:
        return 'Iyl';
      case 8:
        return 'Avg';
      case 9:
        return 'Sen';
      case 10:
        return 'Okt';
      case 11:
        return 'Noy';
      case 12:
        return 'Dek';
    }
    return 'NA';
  }
}
