import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpec_training/app_colors.dart';

class TopScrollablePage extends StatefulWidget {
  final double topRadius;
  final double headerPercentHeight;
  final Widget headerChild;
  final Widget bottomChild;

  const TopScrollablePage(
      {Key key,
      this.topRadius = 70,
      this.headerPercentHeight = 0.35,
      @required this.headerChild,
      @required this.bottomChild})
      : super(key: key);
  @override
  _TopScrollablePageState createState() => _TopScrollablePageState();
}

class _TopScrollablePageState extends State<TopScrollablePage> {
  double _offset = 0;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(onScroll);
  }

  onScroll() {
    setState(() {
      _offset = _scrollController.offset;
    });
  }

  getComputedRadius(double screenHeight) {
    if (_offset > screenHeight * 0.25) {
      return 0.0;
    }
    return widget.topRadius - _offset * 0.25;
  }

  getOffsetAdvanceRatio(double screenHeight) {
    //to slow down image shrinking, dividing _offset
    var modifiedOffset = (_offset / 4);
    if (modifiedOffset >= screenHeight * 0.25) {
      return 1.0;
    }
    return (modifiedOffset / (screenHeight * 0.25));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Container(
                    height: (screenHeight + widget.topRadius) *
                        (widget.headerPercentHeight *
                            (1 - getOffsetAdvanceRatio(screenHeight))),
                    child: widget.headerChild),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: Container(
                    //The more we advance, the bigger it get
                    height: screenHeight *
                        ((1 - widget.headerPercentHeight) +
                            (getOffsetAdvanceRatio(screenHeight))),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.richBlack,
                          border: Border.all(color: AppColors.beige),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  getComputedRadius(screenHeight)),
                              topRight: Radius.circular(
                                  getComputedRadius(screenHeight)))),
                      child: Padding(
                        padding: EdgeInsets.all(widget.topRadius / 4 + 8.0),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: widget.bottomChild,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(onScroll);
    _scrollController.dispose();
  }
}
