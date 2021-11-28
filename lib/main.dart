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
                        heightFactor: 0.2,
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
                          navBarItem(0, 'Home', Icons.home),
                          navBarItem(1, 'Dinner', Icons.restaurant_menu),
                          Container(
                            width: size.width * 0.20,
                          ),
                          navBarItem(2, 'Bookmark', Icons.bookmark),
                          navBarItem(3, 'About', Icons.notifications),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navBarItem(int index, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              icon,
              color: currentIndex == index ? Colors.blue : Colors.grey.shade400,
            ),
            onPressed: () {
              setBottomBarIndex(index);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Text(
            title,
            style: TextStyle(
              color: currentIndex == index ? Colors.blue : Colors.grey.shade400,
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
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(
      Offset(size.width * 0.60, 10),
      radius: const Radius.circular(10.0),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
