import 'package:flutter/rendering.dart';
import 'package:online_learner/library_main.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHideWidget(
      {Key? key,
      required this.child,
      required this.controller,
      this.duration = const Duration(microseconds: 200)})
      : super(key: key);

  @override
  _ScrollToHideWidgetState createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool visible = true;
  double hei = 56.0;


  @override
  void initState() {

    widget.controller.addListener(() {listen();});
    super.initState();

  }


  @override
  void dispose() {
    widget.controller.removeListener(() {listen();});
    super.dispose();
  }

  void listen(){
    final direction = widget.controller.position.userScrollDirection;
    if(direction == ScrollDirection.forward){
      show();
    }
    else if(direction == ScrollDirection.reverse){
      hide();
    }
  }

  void show(){
    if(!visible){
      setState(() {
        visible = true;
      });
    }
  }

  void hide(){
    if(visible){
      setState(() {
        visible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: widget.child,
      duration: widget.duration,
      height: visible ? hei : 0.0,
    );
  }
}
