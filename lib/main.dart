import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '/scroll_to_hide.dart';
import '/scroll_to_hide_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Navbar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  late ScrollController controller;

  @override
  void initState() {
    super.initState();

    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Navbar'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: controller,
            itemCount: 30,
            itemBuilder: (context, index) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('NavBar Test'),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ScrollToHide(
              controller: controller,
              child: Container(
                width: size.width,
                height: 80,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                    ScrollToHideButton(
                      controller: controller,
                      child: Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                          backgroundColor: Colors.blue,
                          child: const Icon(Icons.shopping_basket),
                          elevation: 0.1,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.home,
                              color: currentIndex == 0
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(0);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.restaurant_menu,
                              color: currentIndex == 1
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(1);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          Container(
                            width: size.width * 0.20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: currentIndex == 2
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(2);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.notifications,
                                  color: currentIndex == 3
                                      ? Colors.blue
                                      : Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  setBottomBarIndex(3);
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              Text(
                                'Hello',
                                style: TextStyle(
                                  color: currentIndex == 3
                                      ? Colors.blue
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 10);
    path.lineTo(size.width * 0.35, 10);
    path.quadraticBezierTo(size.width * 0.40, 10, size.width * 0.40, 20);
    path.arcToPoint(
      Offset(size.width * 0.60, 20),
      radius: const Radius.circular(20.0),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 10, size.width * 0.65, 10);
    path.quadraticBezierTo(size.width, 10, size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
