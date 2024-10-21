import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/{{features.snakeCase()}}_bloc.dart';

@RoutePage()
class {{features.pascalCase()}}View extends StatelessWidget implements AutoRouteWrapper {
const {{features.pascalCase()}}View({super.key});
@override
Widget wrappedRoute(context) {
return BlocProvider(
create: (context) => {{features.pascalCase()}}Bloc(),
child: this, // this as the child Important!
);
}
@override
Widget build(BuildContext context) {
return BlocBuilder<{{features.pascalCase()}}Bloc, {{features.pascalCase()}}State>(
     builder: (context, state) {
     return switch (state) {
        {{features.pascalCase()}}Initial() => const Center(child: CircularProgressIndicator(),),
        {{features.pascalCase()}}Loaded() => Builder(
          builder: (context) {
            return const SizedBox();
          }
        ),
        {{features.pascalCase()}}Fail() => const Center(child: CircularProgressIndicator(),),


};
},
);
}
}
