import 'package:flutter/material.dart';
import 'package:teamify/model/players.dart';

class PlayerList extends StatelessWidget {
  final Players players;
  const PlayerList({
    super.key,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: players.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${index + 1}. ${players.get(index)}'),
          trailing: IconButton(
            onPressed: () {
              players.removeAt(index);
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
