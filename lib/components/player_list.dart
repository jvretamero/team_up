import 'package:flutter/material.dart';

class PlayerList extends StatelessWidget {
  final List<String> players;
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
          title: Text('${index + 1}. ${players[index]}'),
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
