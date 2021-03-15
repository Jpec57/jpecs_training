import 'package:flutter/material.dart';
import 'package:jpec_training/app_colors.dart';

class DefaultButton extends StatefulWidget {
  final Function onPressed;
  //text or child is mandatory
  final String text;
  final Widget child;
  final Color buttonColor;
  final Color textColor;

  const DefaultButton(
      {Key key,
      @required this.onPressed,
      this.text,
      this.buttonColor = AppColors.beige,
      this.textColor = Colors.black,
      this.child})
      : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool isSending;

  @override
  void initState() {
    super.initState();
    isSending = false;
  }

  _blockClick() async {
    if (!isSending) {
      setState(() {
        isSending = true;
      });
      await widget.onPressed();
      setState(() {
        isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return GestureDetector(
        onTap: _blockClick,
        child: Container(
          color: widget.buttonColor,
          child: widget.child,
        ),
      );
    }
    return GestureDetector(
      onTap: _blockClick,
      child: Container(
        color: widget.buttonColor,
        child: Text(
          widget.text.toUpperCase(),
          style:
              TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
