import 'package:flutter/material.dart';
import 'package:jpec_training/app_colors.dart';

class TrainingProgressBar extends StatelessWidget {
  final double value;
  final int? elapsedTime;

  const TrainingProgressBar({Key? key, required this.value, this.elapsedTime})
      : super(key: key);

  String formatTimeSection(int number) {
    if (number < 10) {
      return "0$number";
    }
    return "$number";
  }

  String formatElapsedTime() {
    if (elapsedTime! > 3600) {
      int hour = (elapsedTime! / 3600).floor();
      return "${formatTimeSection(hour)}:${formatTimeSection(((elapsedTime! - (hour * 3600)) / 60).floor())}:${formatTimeSection(elapsedTime! % 60)}";
    }
    if (elapsedTime! > 60) {
      return "${formatTimeSection((elapsedTime! / 60).floor())}:${formatTimeSection(elapsedTime! % 60)}";
    }

    return "00:${formatTimeSection(elapsedTime!)}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            "${(value * 100).toInt()}%",
            style: TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: AppColors.beige,
            valueColor:
                new AlwaysStoppedAnimation<Color>(AppColors.greenArtichoke),
          ),
        ),
        elapsedTime == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  formatElapsedTime(),
                  style: TextStyle(fontSize: 14),
                ),
              )
      ],
    );
  }
}
