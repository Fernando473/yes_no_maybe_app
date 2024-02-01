import 'package:flutter/material.dart';
import 'package:yes_no_maybe_app/src/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_maybe_app/src/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();
  final ScrollController scrollController = ScrollController();

  List<Message> messageList = [];

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;
    final newMessage = Message(text: message, fromWho: FromWho.mine);
    messageList.add(newMessage);

    if (message.endsWith('?')) {
      herReply();
    }

    // ! Notificar a todos los que estan escuchando ese cambio
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswers();
    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }
}
