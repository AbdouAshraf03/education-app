import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiPage extends StatefulWidget {
  AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '1');
  final _bot = const types.User(id: '2', firstName: 'AI');

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    // User's message
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: UniqueKey().toString(),
      text: message.text,
      status: types.Status.delivered,
    );

    _addMessage(userMessage);

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 500), () {
      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: UniqueKey().toString(),
        text: message.text,
        status: types.Status.delivered,
      );

      if (mounted) {
        setState(() {
          _messages.insert(0, botMessage);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(_messages.length),
      child: Chat(
        key: Key(_messages.hashCode.toString()),
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          inputContainerDecoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
              // borderRadius: BorderRadius.circular(10),
              ),
          //inputMargin: EdgeInsets.only(bottom: 100, top: 500),

          primaryColor: Colors.blue,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          sentMessageBodyTextStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
          receivedMessageBodyTextStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
          inputTextCursorColor: Colors.blue,
          attachmentButtonIcon: const Icon(Iconsax.camera, color: Colors.white),
        ),
      ),
    );
  }
}
