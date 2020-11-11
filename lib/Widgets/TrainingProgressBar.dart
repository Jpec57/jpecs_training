import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';

class TrainingProgressBar extends StatelessWidget {
  final double value;

  const TrainingProgressBar({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 8, right: 8),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: AppColors.beige,
        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.greenArtichoke),
      ),
    );
  }
}
