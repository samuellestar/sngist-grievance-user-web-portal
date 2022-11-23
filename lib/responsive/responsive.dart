import 'package:flutter/material.dart';

class ResponsiveLayoutLogin extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayoutLogin(
      {Key? key, required this.desktopBody, required this.mobileBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth < 790) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      }),
    );
  }
}
