import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jewellery/style/colors.dart';

class CustomDotIndicator extends StatelessWidget {
   int? itemCount;
   int? currentIndex;
   String? activeDotHtml;
   String? inactiveDotHtml;
   String? color;
  CustomDotIndicator({
     this.itemCount,
    this.currentIndex,
    this.color,
    this.activeDotHtml = '&#9670;', // Filled diamond HTML code
    this.inactiveDotHtml = '&#9671;', // Empty diamond HTML code
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount!, (index) {
        final dotHtml = index == currentIndex ? activeDotHtml : inactiveDotHtml;
        final dotcolor = index == currentIndex? gradient1: gradient2;
        return HtmlWidget(dotHtml!, textStyle: TextStyle(color: dotcolor));
      }),
    );
  }
}