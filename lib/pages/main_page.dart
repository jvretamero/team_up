import 'package:flutter/material.dart';
import 'package:teamify/components/player_sheet.dart';
import 'package:teamify/model/players.dart';
import 'package:teamify/components/player_list.dart';
import 'package:teamify/model/team_drawer.dart';
import 'package:teamify/pages/team_page.dart';
import 'package:flutter/foundation.dart' as foundation;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Players _players = Players();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Team draw'),
        ),
        body: ListenableBuilder(
          listenable: _players,
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
                      child: PlayerList(players: _players),
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
    var totalTeams = TeamDrawer.calculateTeamCount(_players.length);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${_players.length} players'),
        Text('$totalTeams teams'),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _players.isEmpty ? null : _drawTeams,
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
                        _players.add('Player $i');
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
    var drawer = TeamDrawer(_players.asList);
    var teams = drawer.draw();

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
                setState(() {
                  _players.add(player);
                });
              },
            ),
          ),
        );
      },
      showDragHandle: true,
    );
  }
}
