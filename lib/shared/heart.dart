import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

///애니메이션이 여러개라면 SingleTickerProviderStateMixin 말고
///TickerProviderStateMixin를 사용하면 된다.
///또한 AnimationController들을 이용하면 따로 setState를 해주지 않아도
///AnimatedWidget들 안에서는 Widget들의 상태가 변화한다
class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation _sizeAnimation;
  late Animation _curveAnimation;
  bool isFav = false;

  @override
  void initState() {
    ///_controller animation은 Duration의 시간 동안 0 -> 1 에 도달한다
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    ///CurvedAnimation 은 parent 값으로 AnimationController 를 받는다
    _curveAnimation = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    ///_colorAnimation은 회색에서 빨간색으로 _conroller에서 정한 duration 동안 변경된다.
    ///마지막에 .animate(_controller) 붙여야 캐스팅이 된다
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller);

    ///TweenQequence는 두개의 애니메이션을 실행시킬 수 있다
    ///첫번째 TweenSequenceItem 은 30 -> 50,
    ///두번째 TweenSequenceItem 은 50 -> 30 으로
    ///double값을 변경시키는 animation이다
    ///weight 값은 지속시간동안의 퍼센트를 나타낸다
    ///duration 값이 1000, weight값이 50이면 500 이다
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 50, end: 30),
        weight: 50,
      ),
    ]).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    ///_controller 의 상태 변화를 감지해서 시작과 끝을 알려준다
    /// _controller.forward 호출
    ///1. AnimationStatus.forward
    ///2. AnimationStatus.completed
    ///
    ///_controller.reverse 호출
    ///1. AnimationStatus.reverse
    ///2. AnimationStatus.dismissed
    _controller.addStatusListener((status) {
      print("_controller :${status}");

      if (status == AnimationStatus.completed) {
        setState(() => isFav = true);
      }
      if (status == AnimationStatus.dismissed) {
        setState(() => isFav = false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///AnimatedBuilder 에서 시간을 세팅하는 것은 _controller
    /// color 값을 변경시키는 것은 _colorAnimation
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: _sizeAnimation.value,
          ),
          onPressed: () {
            print("isFav :$isFav");
            isFav ? _controller.reverse() : _controller.forward();
          },
        );
      },
    );
  }
}
