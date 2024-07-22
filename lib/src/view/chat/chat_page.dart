// lib/pages/chat_detail_page.dart

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:merem_chat_app/di.dart';
import 'package:merem_chat_app/src/models/chat.dart';
import 'package:merem_chat_app/src/models/message.dart';
import 'package:merem_chat_app/src/models/user.dart';
import 'package:merem_chat_app/src/viewmodels/chat_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChatDetailPage extends StatefulWidget {
  final String chatId;
  final String username;

  const ChatDetailPage(
      {super.key, required this.chatId, required this.username});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final types.User _user =
      types.User(id: FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<ChatViewModel>()..loadMessages(widget.chatId),
      child: Consumer<ChatViewModel>(
        builder: (context, chatViewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  context.router.pop();
                },
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      widget.username.isNotEmpty ? widget.username[0] : '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.username.isEmpty ? 'Chat' : widget.username,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            body: StreamBuilder<List<MessageModel>>(
              stream: chatViewModel.getMessageStream(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.map((message) {
                  return types.TextMessage(
                    author: types.User(id: message.authorId),
                    createdAt: message.createdAt,
                    id: message.id,
                    text: message.text,
                  );
                }).toList();

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: Chat(
                    messages: messages,
                    onSendPressed: (message) => chatViewModel.sendMessage(
                        message.text, _user.id, widget.chatId),
                    user: _user,
                    emptyState: const Center(
                      child: Text('No messages yet.'),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
