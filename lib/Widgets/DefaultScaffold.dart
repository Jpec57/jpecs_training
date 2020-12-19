import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Widgets/MainDrawer.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget child;
  final bool withAppBar;

  const DefaultScaffold({Key key, @required this.child, this.withAppBar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: withAppBar
            ? AppBar(
                elevation: 0.0,
                backgroundColor: AppColors.richBlack,
              )
            : null,
        drawer: withAppBar ? MainDrawer() : Container(),
        body: SafeArea(
          child: child,
        ));
  }
}
