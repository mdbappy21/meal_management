import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mess-1'),
      ),
      body: Column(
        children: [
          Text('Message will be here'),
        ],
      ),
    );
  }
}
