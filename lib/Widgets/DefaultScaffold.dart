import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Widgets/MainDrawer.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget child;

  const DefaultScaffold({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.richBlack,
        ),
        drawer: MainDrawer(),
        body: SafeArea(
          child: child,
        ));
  }
}
