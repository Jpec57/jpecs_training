import 'dart:async';

// import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpec_training/app_colors.dart';
import 'package:jpec_training/widgets/default_scaffold.dart';
import 'package:wakelock/wakelock.dart';

class TimerPage extends StatefulWidget {
  static const routeName = '/timer';

  @override
  _TimerPageState createState() => _TimerPageState();
}

const CACHED_SOUNDS = ['sounds/beep_start.mp3', 'sounds/beep_end.mp3'];

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  static const CHOICE_TAB_INDEX = 0;
  static const TIMER_TAB_INDEX = 1;
  TabController _tabController;
  int _currentSet = 6;
  int _countdown = 0;
  Timer _timer;
  //Audio
  // AudioCache _audioPlayer = AudioCache();

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    _tabController = new TabController(length: 2, vsync: this);
    // _audioPlayer.loadAll(CACHED_SOUNDS);
  }

  @override
  void dispose() {
    Wakelock.disable();
    _tabController.dispose();
    for (String sound in CACHED_SOUNDS) {
      // _audioPlayer.clear(sound);
    }
    super.dispose();
  }

  void onTimerPress(int time) {
    if (_currentSet > 0) {
      _currentSet--;
    }
    setState(() {
      _countdown = time;
    });
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown = _countdown - 1;
      });

      if (_countdown == 10) {
        // _audioPlayer.play(CACHED_SOUNDS[0]);
      }

      if (_countdown < 3) {
        // _audioPlayer.play(CACHED_SOUNDS[(_countdown == 0) ? 1 : 0]);
      }
      if (_countdown <= 0) {
        _timer.cancel();
        Future.delayed(Duration(milliseconds: 200), () {
          _tabController.index = CHOICE_TAB_INDEX;
        });
      }
    });
    Future.delayed(Duration(milliseconds: 200), () {
      _tabController.index = TIMER_TAB_INDEX;
    });
  }

  Widget _renderTimerButton(int time) {
    return Expanded(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              onTimerPress(time);
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.charlestonGreen,
              elevation: 8.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
            child: Text(
              "$time",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontFamily: 'Roboto'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderTimerRow(int time1, int time2) {
    return Expanded(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderTimerButton(time1),
          _renderTimerButton(time2),
        ],
      ),
    );
  }

  Widget _renderSet(int setNumber) {
    Color backgroundColor = AppColors.richBlack;
    Color textColor = Colors.white;
    if (_currentSet == setNumber) {
      backgroundColor = AppColors.greenArtichoke;
      textColor = Colors.white;
    }
    return Expanded(
        child: InkWell(
      onTap: () {
        setState(() {
          _currentSet = setNumber;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.richBlack,
        ),
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                    border:
                        Border.all(color: AppColors.charlestonGreen, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    '$setNumber',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ))),
      ),
    ));
  }

  Widget _renderSetRow() {
    return Expanded(
      flex: 1,
      child: Container(
        color: AppColors.richBlack,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            _renderSet(0),
            _renderSet(1),
            _renderSet(2),
            _renderSet(3),
            _renderSet(4),
            _renderSet(5),
            _renderSet(6),
          ],
        ),
      ),
    );
  }

  Widget _renderTimer() {
    return Container(
      color: AppColors.greenArtichoke,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$_countdown",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.charlestonGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text("Skip"),
                  onPressed: () {
                    if (_timer.isActive) {
                      _timer.cancel();
                    }
                    _countdown = 0;
                    setState(() {
                      _tabController.index = CHOICE_TAB_INDEX;
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _renderTabs() {
    return [
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderTimerRow(25, 60),
          _renderTimerRow(90, 120),
          _renderTimerRow(240, 360),
        ],
      ),
      _renderTimer(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderSetRow(),
          Expanded(
            flex: 6,
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: _renderTabs(),
            ),
          )
        ],
      ),
    );
  }
}
