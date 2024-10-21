import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';


part '{{features.snakeCase()}}_event.dart';
part '{{features.snakeCase()}}_state.dart';

class {{features.pascalCase()}}Bloc extends Bloc<{{features.pascalCase()}}Event, {{features.pascalCase()}}State> {
{{features.pascalCase()}}Bloc() : super({{features.pascalCase()}}Loaded()) {
on<{{features.pascalCase()}}Event>((event, emit) {
// TODO: implement event handler
});
}
}