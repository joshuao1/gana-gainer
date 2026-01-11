import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  final Widget child;
  final Color color;

  const StyledContainer({
    super.key,
    required this.child,
    this.color = const Color.fromARGB(255, 255, 255, 255),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(),
          ),
        ],
      ),
      child: child,
    );
  }
}
