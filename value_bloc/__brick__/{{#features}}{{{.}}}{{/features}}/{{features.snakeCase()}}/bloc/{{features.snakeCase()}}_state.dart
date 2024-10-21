part of '{{features.snakeCase()}}_bloc.dart';

@immutable
sealed class {{features.pascalCase()}}State {
const {{features.pascalCase()}}State();
}
class {{features.pascalCase()}}Initial extends {{features.pascalCase()}}State {}
class {{features.pascalCase()}}Loaded extends {{features.pascalCase()}}State {}
class {{features.pascalCase()}}Fail extends {{features.pascalCase()}}State {}
