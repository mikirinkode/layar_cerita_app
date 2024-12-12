import 'package:flutter/material.dart';
import 'package:layar_cerita_app/utils/build_context.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: PageController(viewportFraction: 1),
        itemBuilder: (BuildContext context, int itemIndex) {
          return _buildCarouselItem(context, itemIndex);
        },
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    final listOfColor = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ];
    return Container(
      decoration: BoxDecoration(
        color: listOfColor[itemIndex % listOfColor.length],
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
  }
}
