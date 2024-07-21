// lib/pages/home_page.dart

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merem_chat_app/di.dart';
import 'package:merem_chat_app/routes/app_router.dart';
import 'package:merem_chat_app/src/models/user.dart';
import 'package:merem_chat_app/src/viewmodels/chat_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;

    return ChangeNotifierProvider(
      create: (context) => getIt<ChatViewModel>()
        ..loadUsersExceptCurrent(user!.uid)
        ..loadChats(user.uid),
      child: Scaffold(
        body: Consumer<ChatViewModel>(
          builder: (context, chatViewModel, child) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.primaryColor, theme.colorScheme.secondary],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Messages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand',
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.menu,
                              size: 36,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'R E C E N T',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: chatViewModel.users.length,
                          itemBuilder: (context, index) {
                            final user = chatViewModel.users[index];

                            return InkWell(
                              onTap: () => context.router.push(
                                ChatDetailRoute(
                                    chatId: user
                                        .id), //this is not the right implementation we shold send chat id if they already talk, if not null.
                              ),
                              child: _buildChatItem(user, 'No messages yet'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatItem(
    UserModel user,
    String message,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: Text(
              user.username[0],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 17,
                      ),
                    ),
                    // Text(
                    //   DateTime.now().toString(),
                    // ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
