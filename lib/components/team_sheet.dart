import 'package:flutter/material.dart';
import 'package:teamup/components/bottom_sheet_base.dart';
import 'package:teamup/model/team.dart';
import 'package:teamup/model/team_viewmodel.dart';
import 'package:teamup/pages/team_page.dart';

class TeamSheet extends StatefulWidget {
  final TeamViewModel viewModel;
  const TeamSheet({
    super.key,
    required this.viewModel,
  });

  @override
  State<TeamSheet> createState() => _TeamSheetState();
}

class _TeamSheetState extends State<TeamSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${widget.viewModel.teamCount} teams'),
              Text('${widget.viewModel.playerCount} players'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _generateTeams,
                child: const Text('Continue'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _generateTeams() {
    var teams = widget.viewModel.generateTeams();

    _navigateToTeamsPage(teams);
  }

  void _navigateToTeamsPage(List<Team> teams) {
    var navigator = Navigator.of(context);
    navigator.pop();
    navigator.push(
      MaterialPageRoute(
        builder: (context) => TeamsPage(teams: teams),
      ),
    );
  }
}
