import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';

//TODO
class TrainingProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.greenArtichoke,
          borderRadius: BorderRadius.circular(10)),
      height: 20,
      width: 200,
    );
  }
}
