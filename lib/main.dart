import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyAppState()
    )
  );
}

class MyAppState extends StatefulWidget {
  const MyAppState({super.key});

  @override
  State<MyAppState> createState() => _MyAppStateState();
}
  
class _MyAppStateState extends State<MyAppState> {
  final double boxSize = 150.0;
  int numTaps = 0;
  int numDoubleTaps = 0;
  int numLongPress = 0;
  double posX = 0.0;
  double posY = 0.0;

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30;

    setState(() {
      this.posX = posX;
      this.posY = posY;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (posX == 0) {
      center(context);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Detector')),
      body: Stack(
        children: [
          Positioned(
            top: posY,
            left: posX,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  numTaps++;
                });
              },
              onDoubleTap: () {
                setState(() {
                  numDoubleTaps++;
                });
              },
              onLongPress: () {
                setState(() {
                  numLongPress++;
                });
              },
              // onVerticalDragUpdate: (DragUpdateDetails details) {
              //   setState(() {
              //     double delta = details.delta.dy;
              //     posY += delta;
              //   });
              // },
              // onHorizontalDragUpdate: (DragUpdateDetails details) {
              //   setState(() {
              //     double delta = details.delta.dx;
              //     posX += delta;
              //   });
              // },
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  double deltaX = details.delta.dx;
                  double deltaY = details.delta.dy;
                  posX += deltaX;
                  posY += deltaY;
                });
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Tap: $numTaps - Double Taps: $numDoubleTaps - Long Press: $numLongPress', 
          style: Theme.of(context).textTheme.headline6,   
        ),
      ),
    );
  }
}
