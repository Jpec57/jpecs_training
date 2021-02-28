import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpec_training/app_colors.dart';
import 'package:jpec_training/models/exercise.dart';
import 'package:jpec_training/widgets/default_button.dart';

class ExerciseExplanationDialog extends StatelessWidget {
  static const RADIUS = 32.0;
  final Exercise exercise;

  const ExerciseExplanationDialog({Key key, this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.charlestonGreen,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(RADIUS)),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.beige),
              borderRadius: BorderRadius.all(
                Radius.circular(RADIUS),
              ),
            ),
            width: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Exercise name',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      'Description',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: DefaultButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      text: "Close",
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
