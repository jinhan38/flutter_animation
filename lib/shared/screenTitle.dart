import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///TweenAnimation은 커스텀으로 만들 수 있는 애니메이션이다.
    ///시작점과 끝점, 그리고 타입을 Tween으로 정할 수 있다.
    ///builder에서는 TweenAnimationBuilder의 context, tween의 값, builder의 child를 받아온다.
    ///그리고 그에 해당하는 변화들을 만들어주면 된다.
    ///여기서는 해당 위젯이 빌드되면  0.5초 동안 Opacity가 0에서 1로 변화하고 topMargin값이 20으로 변화한다
    return TweenAnimationBuilder(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      duration: Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1 ),
      curve: Curves.easeIn,
      builder: (context, double _val, child) {
        return Opacity(
          opacity: _val,
          child: Padding(
            padding:  EdgeInsets.only(top: _val *50),
            child: child,
          ),
        );
      },
    );
  }
}
