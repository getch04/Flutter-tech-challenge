// lib/viewmodels/chat_view_model.dart

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:merem_chat_app/src/models/chat.dart';
import 'package:merem_chat_app/src/models/message.dart';
import 'package:merem_chat_app/src/models/user.dart';
import 'package:merem_chat_app/src/services/chat_service.dart';

@injectable
class ChatViewModel extends ChangeNotifier {
  final ChatService _chatService;
  final List<ChatModel> _chats = [];
  final List<MessageModel> _messages = [];
  final List<UserModel> _users = [];

  ChatViewModel(this._chatService);

  List<ChatModel> get chats => _chats;
  List<MessageModel> get messages => _messages;
  List<UserModel> get users => _users;

  Future<void> loadChats(String userId) async {
    _chatService.getChats(userId).listen((chats) {
      _chats.clear();
      _chats.addAll(chats);
      notifyListeners();
    });
  }

  Future<void> loadMessages(String chatId) async {
    _chatService.getMessages(chatId).listen((messages) {
      _messages.clear();
      _messages.addAll(messages);
      notifyListeners();
    });
  }

  Future<void> sendMessage(String text, String authorId, String chatId) async {
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: authorId,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    await _chatService.sendMessage(message, chatId);
  }

  Future<void> createChat(String currentUserId, List<String> peerIds) async {
    await _chatService.createChat(currentUserId, peerIds);
    notifyListeners();
  }

  Future<void> loadUsersExceptCurrent(String userId) async {
    final users = await _chatService.getUsersExceptCurrent(userId);
    _users.clear();
    _users.addAll(users);
    notifyListeners();
  }
}
