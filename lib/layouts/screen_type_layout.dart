import 'package:flutter/widgets.dart';
import 'package:jetdispatch/enums/device_screen_type.dart';
import 'package:jetdispatch/layouts/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ScreenTypeLayout({Key? key, this.mobile, this.tablet, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
        if (tablet != null) {
          return tablet as Widget;
        }
      }

      // If sizing indicates desktop and we have a desktop widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
        if (desktop != null) {
          return desktop as Widget;
        }
      }

      // Return mobile layout if nothing else is supplied
      return mobile as Widget;
    });
  }
}
