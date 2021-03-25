import 'package:flutter/material.dart';
import 'package:jpec_training/app_colors.dart';
import 'package:jpec_training/services/utils/time_utils.dart';

class TrainingProgressBar extends StatelessWidget {
  final double value;
  final int elapsedTime;

  const TrainingProgressBar(
      {Key? key, required this.value, required this.elapsedTime})
      : super(key: key);

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
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            TimeUtils.formatElapsedTime(elapsedTime),
            style: TextStyle(fontSize: 14),
          ),
        )
      ],
    );
  }
}
