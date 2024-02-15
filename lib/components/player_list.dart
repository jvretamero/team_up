import 'package:flutter/material.dart';
import 'package:teamup/model/team_viewmodel.dart';

class PlayerList extends StatelessWidget {
  final TeamViewModel viewModel;
  const PlayerList({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: viewModel.playerCount,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${index + 1}. ${viewModel.getPlayer(index)}'),
          trailing: IconButton(
            onPressed: () {
              viewModel.removePlayerAt(index);
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
