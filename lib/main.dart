import 'package:flutter/material.dart';
import 'data.dart';
import 'Page_indicator.dart';
import 'package:gradient_text/gradient_text.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool isLastPage = false;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF485563), Color(0xFF29323C)],
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            stops: [0.0, 1.0],
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              itemCount: pageList.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  isLastPage = currentPage == pageList.length - 1;
                  if (isLastPage) {
                    animationController.forward();
                  } else {
                    animationController.reset();
                  }
                });
                print(isLastPage);
              },
              itemBuilder: (context, index) => AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) => animatedPageViewBuilder(index),
                  ),
            ),
            Positioned(
              left: 30.0,
              bottom: 55.0,
              width: 160.0,
              child: PageIndicator(currentPage, pageList.length),
            ),
            Positioned(
              right: 30.0,
              bottom: 30.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: isLastPage
                    ? FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_forward, color: Colors.black),
                        onPressed: () {},
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget animatedPageViewBuilder(int index) {
    PageModel page = pageList[index];
    double delta;
    double y = 1.0;

    if (_controller.position.haveDimensions) {
      delta = _controller.page - index;
      y = delta.abs().clamp(0.0, 1.0);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(page.imageUrl),
        Container(
          margin: EdgeInsets.only(left: 12.0),
          height: 100.0,
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: .10,
                child: GradientText(
                  page.title,
                  gradient: LinearGradient(colors: page.titleGradient),
                  style: TextStyle(
                      fontSize: 100.0,
                      fontFamily: "Montserrat-Black",
                      letterSpacing: 1.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, left: 22.0),
                child: GradientText(
                  page.title,
                  gradient: LinearGradient(colors: page.titleGradient),
                  style:
                      TextStyle(fontSize: 70.0, fontFamily: "Montserrat-Black"),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 34.0, top: 12.0),
          transform: Matrix4.translationValues(0, 50.0 * y, 0),
          child: Text(
            page.body,
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Montserrat-Medium",
                color: Color(0xFF9B9B9B)),
          ),
        )
      ],
    );
  }
}
