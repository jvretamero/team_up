import 'package:flutter/material.dart';

class BottomSheetBase extends StatelessWidget {
  final Widget child;

  const BottomSheetBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 32.0,
          left: 32.0,
          right: 32.0,
          top: 32.0,
        ),
        child: child,
      ),
    );
  }
}
