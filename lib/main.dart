import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merem_chat_app/core/helpers/navigator_service.dart';
import 'package:merem_chat_app/src/view/auth/login_page.dart';
import 'package:merem_chat_app/src/viewmodels/auth_view_model.dart';
import 'package:merem_chat_app/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(NavigationService.instance),
        ),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.instance.navigationKey,
        title: 'Flutter Chat App Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const LoginPage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: const Center(
        child: Text('Welcome to the Chat App'),
      ),
    );
  }
}
