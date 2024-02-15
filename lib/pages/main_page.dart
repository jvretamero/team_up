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
                      child: PlayerList(viewModel: _viewModel),
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
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _viewModel.isPlayersEmpty ? null : _showTeamSheet,
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
}
