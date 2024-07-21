import 'package:auto_route/auto_route.dart';
import 'package:merem_chat_app/src/view/auth/auth.dart';
import 'package:merem_chat_app/src/view/chat/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
