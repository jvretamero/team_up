import 'package:flutter/material.dart';
import 'package:teamup/components/bottom_sheet_base.dart';

class NewPlayerSheet extends StatefulWidget {
  final Function(String) onPlayer;

  const NewPlayerSheet({
    super.key,
    required this.onPlayer,
  });

  @override
  State<NewPlayerSheet> createState() => _NewPlayerSheetState();
}

class _NewPlayerSheetState extends State<NewPlayerSheet> {
  final TextEditingController _controller = TextEditingController();
  late int _count;

  @override
  void initState() {
    super.initState();

    _count = 0;
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
    return BottomSheetBase(
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
