import 'package:flutter/material.dart';
import 'package:teamup/model/team.dart';

class TeamsPage extends StatelessWidget {
  final List<Team> teams;

  const TeamsPage({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teams'),
        ),
        body: ListView.separated(
          itemCount: teams.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            var team = teams[index];

            var teamPlayers = team.players.map(
              (player) => ListTile(
                title: Text(player),
              ),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(
                  'Team ${index + 1}',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
                ...teamPlayers,
              ],
            );
          },
        ),
      ),
    );
  }
}
