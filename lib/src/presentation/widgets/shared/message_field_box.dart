import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    //final colors = Theme.of(context).colorScheme;
    final outLineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Colors.transparent));

    final textController = TextEditingController();
    final focusNode = FocusNode();

    final inputDecoration = InputDecoration(
        hintText: "Your message end with a ?",
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;

            textController.clear();

            onValue(textValue);
          },
        ),
        filled: true,
        enabledBorder: outLineInputBorder,
        focusedBorder: outLineInputBorder);

    return TextFormField(
      decoration: inputDecoration,
      controller: textController,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        onValue(value);
      },
    );
  }
}
