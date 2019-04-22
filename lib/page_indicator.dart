import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  PageIndicator(this.currentIndex, this.pageCount);

  Widget _indicator(int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: 4.0,
        decoration: BoxDecoration(
            color: index == currentIndex ? Colors.white : Color(0xFF3E4750),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 2.0)
            ]),
      ),
    );
  }

  List<Widget> _buildPageIndicators() => List.generate(pageCount, _indicator);

  @override
  Widget build(BuildContext context) => Row(children: _buildPageIndicators());
}
