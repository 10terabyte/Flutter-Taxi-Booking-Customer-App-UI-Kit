import 'package:flutter/material.dart';

class InkWellCustom extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;

  const InkWellCustom({Key? key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
