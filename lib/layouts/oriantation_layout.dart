import 'package:flutter/widgets.dart';

class OrientationLayout extends StatelessWidget {
  final Widget? landscape;
  final Widget? portrait;
  const OrientationLayout({
    Key? key,
    this.landscape,
    this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape as Widget;
    } else if (orientation == Orientation.portrait) {
      return portrait as Widget;
    } else {
      return portrait as Widget;
    }
  }
}
