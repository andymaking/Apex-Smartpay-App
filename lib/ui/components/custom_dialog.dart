import 'package:Smartpay/theme/theme_config.dart';
import 'package:Smartpay/ui/components/button.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  Function()? onPressed;
  String title;
  bool isError;

  ShowDialog(
      {Key? key, required this.onPressed, required this.title,
        required this.isError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isError ? ThemeConfig.redColor : ThemeConfig.darkAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 16.0, bottom: 15),
            child: Text(title,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  color: ThemeConfig.lightPrimary,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppStrings.fontFamily),
            ),
          ),
          Sized24Container(
            child: AppButton(
                onPressed: isError == true
                    ? (){
                  Navigator.of(context).pop();
                }
                    : onPressed,
                title: 'Dismiss',
                enabled: true),
          ),
          const SizedBox(height: 14,)
        ],
      ),
    );
  }
}

Future<T>? showTopModalSheet<T>({ required BuildContext context, required Widget child, }) {
   Navigator.of(context).push(PageRouteBuilder<T>(pageBuilder: (_, __, ___) {
    return TopModalSheet<T>(child: child, );
  }, opaque: false));
}

class TopModalSheet<T> extends StatefulWidget {
  final Widget child;
  Color backgroundColor;

  TopModalSheet({Key? key, required this.child, this.backgroundColor =  Colors.transparent}): super(key: key);

  @override
  TopModalSheetState<T> createState() => TopModalSheetState<T>();
}

class TopModalSheetState<T> extends State<TopModalSheet<T>> with SingleTickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey();
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool _isPoping = false;

  double? get _childHeight {
    final renderBox = _childKey.currentContext?.findRenderObject() as RenderBox ;
    return renderBox.size.height;
  }

  bool get _dismissUnderway => _animationController!.status == AnimationStatus.reverse;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: -1, end: 0).animate(_animationController!);

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if(!_isPoping) {
          Navigator.pop(context);
        }
      };
    });

    _animationController!.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway) return;

    var change = details.primaryDelta! / (_childHeight!);
    _animationController!.value += change;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;

    if (details.velocity.pixelsPerSecond.dy > 0) return;

    if (details.velocity.pixelsPerSecond.dy > 700) {
      final double flingVelocity = -details.velocity.pixelsPerSecond.dy / _childHeight!;
      if (_animationController!.value > 0.0) {
        _animationController!.fling(velocity: flingVelocity);
      }
    } else if (_animationController!.value < 0.5) {
      if (_animationController!.value > 0.0) {
        _animationController!.fling(velocity: -1.0);
      }
    } else {
      _animationController!.reverse();
      widget.backgroundColor = Colors.transparent;
      setState(() { });
    }
  }

  Future<bool> onBackPressed({dynamic data}) async {
    _animationController!.reverse();
    widget.backgroundColor = Colors.transparent;
    setState(() {  });

    if(data != null){
      _isPoping = true;
      Navigator.of(context).pop(data);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: GestureDetector(
          onVerticalDragUpdate: _handleDragUpdate,
          onVerticalDragEnd: _handleDragEnd,
          excludeFromSemantics: true,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: widget.backgroundColor,
              body: Column(
                key: _childKey,
                children: <Widget>[
                  AnimatedBuilder(animation: _animation!, child: widget.child, builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(0.0, MediaQuery.of(context).size.height * _animation!.value, 0.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(behavior: HitTestBehavior.opaque, child: child, onTap: () {}, ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
