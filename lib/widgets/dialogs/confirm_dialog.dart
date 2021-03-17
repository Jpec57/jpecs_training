import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String action;
  final Function positiveCallback;
  final Function? negativeCallback;
  final bool shouldAlwaysPop;

  const ConfirmDialog(
      {Key? key,
      required this.action,
      required this.positiveCallback,
      this.negativeCallback,
      this.shouldAlwaysPop = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.all(10.0),
      title: Text(
        "Confirm",
        style: TextStyle(color: Colors.black),
      ),
      content: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  action,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                            ),
                            // color: Color(COLOR_DARK_BLUE),
                            child: Text(
                              "No".toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (negativeCallback != null) {
                                negativeCallback!();
                              }
                              Navigator.pop(context, false);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                            ),
                            // color: Color(COLOR_ORANGE),
                            child: Text(
                              "Yes".toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (shouldAlwaysPop) {
                                Navigator.pop(context, true);
                              }
                              positiveCallback();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
