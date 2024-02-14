import 'package:flutter/material.dart';
import 'package:teamup/components/player_sheet.dart';
import 'package:teamup/components/player_list.dart';
import 'package:teamup/model/team.dart';
import 'package:teamup/model/team_viewmodel.dart';
import 'package:teamup/pages/team_page.dart';
import 'package:flutter/foundation.dart' as foundation;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TeamViewModel _viewModel = TeamViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Team draw'),
        ),
        body: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: PlayerList(players: _viewModel.playersList),
                    ),
                  ),
                  _buttonsSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buttonsSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${_viewModel.playerCount} players'),
        Text('${_viewModel.teamCount} teams'),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _viewModel.isPlayersEmpty ? null : _drawTeams,
                child: const Text('Draw teams'),
              ),
            ),
            IconButton.filled(
              onPressed: _showPlayerInput,
              icon: const Icon(Icons.add),
            ),
            foundation.kDebugMode
                ? IconButton.filled(
                    onPressed: () {
                      for (int i = 0; i < 20; i++) {
                        _viewModel.addPlayer('Player $i');
                      }
                    },
                    icon: const Icon(Icons.data_object),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  void _drawTeams() {
    var teams = _viewModel.generateTeams();

    _navigateToTeamsPage(teams);
  }

  void _navigateToTeamsPage(List<Team> teams) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TeamsPage(teams: teams),
      ),
    );
  }

  void _showPlayerInput() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: PlayerSheet(
              onPlayer: (player) {
                _viewModel.addPlayer(player);
              },
            ),
          ),
        );
      },
      showDragHandle: true,
    );
  }
}
