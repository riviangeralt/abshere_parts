import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.radius = 20,
    this.padding = 8,
    required this.child,
  });

  final double radius;
  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
      ),
      child: child,
    );
  }
}
