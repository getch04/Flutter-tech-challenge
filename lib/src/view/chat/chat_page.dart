// lib/pages/chat_detail_page.dart

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:merem_chat_app/di.dart';
import 'package:merem_chat_app/src/viewmodels/chat_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChatDetailPage extends StatefulWidget {
  final String chatId;

  const ChatDetailPage({super.key, required this.chatId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final types.User _user = types.User(id: FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<ChatViewModel>()..loadMessages(widget.chatId),
      child: Consumer<ChatViewModel>(
        builder: (context, chatViewModel, child) {
          final messages = chatViewModel.messages.map((message) {
            return types.TextMessage(
              author: types.User(id: message.authorId),
              createdAt: message.createdAt,
              id: message.id,
              text: message.text,
            );
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Chat'),
            ),
            body: Chat(
              messages: messages,
              onSendPressed: (message) => chatViewModel.sendMessage(message.text, _user.id, widget.chatId),
              user: _user,
            ),
          );
        },
      ),
    );
  }
}
