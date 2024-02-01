import 'package:flutter/material.dart';
import 'package:yes_no_maybe_app/src/domain/entities/message.dart';
import 'package:yes_no_maybe_app/src/presentation/providers/chat_provider.dart';
import 'package:yes_no_maybe_app/src/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_maybe_app/src/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_maybe_app/src/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfFW_uBJKB0gGJI99w-A-pWiO-LRqiaWGsIA&usqp=CAU"),
          ),
        ),
        title: const Text("Mi amor"),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];
                return (message.fromWho == FromWho.hers)
                    ? HerMessageBubble(message: message)
                    : MyMessageBubble(message: message);
              },
              controller: chatProvider.scrollController,
            )),
            // Caja de texto
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            )
          ],
        ),
      ),
    );
  }
}
