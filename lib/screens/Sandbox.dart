import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({Key? key}) : super(key: key);

  @override
  _SandboxState createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  double _opacity = 1;
  double _margin = 0;
  double _width = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: _width,
        color: _color,
        margin: EdgeInsets.all(_margin),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () => setState(() => _margin = 50),
              child: Text("Animation margin"),
            ),
            ElevatedButton(
              onPressed: () => setState(() => _color = Colors.green),
              child: Text("Animation Color"),
            ),
            ElevatedButton(
              onPressed: () => setState(() => _width = 400),
              child: Text("Animation Width"),
            ),
            ElevatedButton(
              onPressed: () => setState(() => _opacity = 0),
              child: Text("Animation Opacity"),
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 3),
              child: Text(
                "Opacity change",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
