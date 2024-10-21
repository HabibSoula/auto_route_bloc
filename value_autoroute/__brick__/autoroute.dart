import 'package:auto_route/auto_route.dart';
import 'autoroute.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
  {{#features}}
AutoRoute(page:{{.}}Route.page),
{{/features}}
];
}
