import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  var childRadios = 0.0;
  double maxSlide = 225.0;
  late AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );

  void toggle() {
    if (_animationController.isDismissed) {
      _animationController.forward();
      childRadios = 30.0;
    } else {
      _animationController.reverse().whenComplete(() => childRadios = 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
          onTap: toggle,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              var slide = _animationController.value * maxSlide;
              var scale = 1 - (_animationController.value * 0.3);
              return Stack(
                children: [
                  myDrawer(),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: myChild(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget myDrawer() {
    return Container(
      color: Colors.blueAccent[200],
      child: Row(
        children: [
          Flexible(
            flex: 55,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Header",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  ListTile(
                    title: Text("test1"),
                    onTap: () {},
                  ),
                  ListTile(title: Text("test2"), onTap: () {}),
                  ListTile(title: Text("test3"), onTap: () {}),
                  ListTile(title: Text("test4"), onTap: () {}),
                  ListTile(title: Text("test5"), onTap: () {}),
                  ListTile(title: Text("test6"), onTap: () {}),
                  ElevatedButton(
                    onPressed: toggle,
                    child: Text("Exit"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myChild() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 30.0, color: Colors.black)],
        borderRadius: BorderRadius.all(
          Radius.circular(childRadios),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(childRadios)),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Click menu"),
            leading: IconButton(
              onPressed: toggle,
              icon: Icon(Icons.view_headline),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 30.0, color: Colors.black)],
              gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.redAccent],
                  begin: Alignment.topCenter),
            ),
          ),
        ),
      ),
    );
  }
}
