import 'package:flutter/material.dart';

class PlayerSheet extends StatefulWidget {
  final Function(String) onPlayer;

  const PlayerSheet({
    super.key,
    required this.onPlayer,
  });

  @override
  State<PlayerSheet> createState() => _PlayerSheetState();
}

class _PlayerSheetState extends State<PlayerSheet> {
  final TextEditingController _controller = TextEditingController();
  int _count = 0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _count = _controller.text.length;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'What is the player\'s name?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            autofocus: true,
            controller: _controller,
            onSubmitted: (value) {
              _notify();
            },
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Player name',
            ),
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            onPressed: _count == 0 ? null : _notify,
            child: const Text('Add player'),
          )
        ],
      ),
    );
  }

  void _notify() {
    widget.onPlayer(_controller.text);
    Navigator.of(context).pop();
  }
}
