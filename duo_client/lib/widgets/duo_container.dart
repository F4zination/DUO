import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';

class DuoContainer extends StatelessWidget {
  final double? width, height;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  const DuoContainer({
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.border,
    this.backgroundColor,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(Constants.defaultRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              // color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: child);
  }
}
