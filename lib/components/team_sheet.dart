import 'package:flutter/material.dart';
import 'package:teamup/components/bottom_sheet_base.dart';

class TeamSheet extends StatefulWidget {
  const TeamSheet({super.key});

  @override
  State<TeamSheet> createState() => _TeamSheetState();
}

class _TeamSheetState extends State<TeamSheet> {
  @override
  Widget build(BuildContext context) {
    return const BottomSheetBase(
      child: Placeholder(),
    );
  }
}
