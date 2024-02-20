import 'package:flutter/material.dart';
import 'package:teamup/components/new_player_sheet.dart';
import 'package:teamup/components/player_list.dart';
import 'package:teamup/components/team_configuration_sheet.dart';
import 'package:teamup/model/team_viewmodel.dart';
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
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Team draw'),
              actions: _actions(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _showPlayerInput,
              child: const Icon(Icons.add),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: PlayerList(viewModel: _viewModel),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _actions() {
    return [
      IconButton(
        onPressed: _viewModel.isPlayersEmpty ? null : _showTeamSheet,
        icon: const Icon(Icons.group_add),
      ),
      IconButton(
        onPressed: _viewModel.isPlayersEmpty ? null : _deleteAllPlayers,
        icon: const Icon(Icons.delete),
      ),
      if (foundation.kDebugMode)
        IconButton(
          onPressed: () {
            for (int i = 0; i < 20; i++) {
              _viewModel.addPlayer('Player $i');
            }
          },
          icon: const Icon(Icons.data_object),
        )
    ];
  }

  void _showPlayerInput() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NewPlayerSheet(
          onPlayer: (player) {
            _viewModel.addPlayer(player);
          },
        );
      },
      showDragHandle: true,
    );
  }

  void _showTeamSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TeamConfigurationSheet(viewModel: _viewModel);
      },
      showDragHandle: true,
    );
  }

  void _deleteAllPlayers() {
    _viewModel.removeAllPlayers();
  }
}
