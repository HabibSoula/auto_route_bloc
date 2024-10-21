import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

/// Capitalizes the first letter of a string and makes the rest lowercase.
String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

void run(HookContext context) async {
  // TODO: add pre-generation logic.
  final features = context.vars['features'] as List;
  final capitalizedFeatures =
      features.map((f) => capitalize(f.toString().trim())).toList();

  for (int i = 0; i < features.length; i++) {}
  var vars = <String, dynamic>{
    'features': capitalizedFeatures,
  };
  context.logger.info('Parent Brick - Passing to Child Brick: $vars');
  final brick =
      Brick.path("C:/Users/HabibSoula/Desktop/Project/bloc_brick/value_bloc");
  final generator = await MasonGenerator.fromBrick(brick);
  for (final f in features) {
    final directory = Directory(
      path.join(Directory.current.path),
    );
    final target = DirectoryGeneratorTarget(directory);

    // Generate files with updated vars
    final files = await generator.generate(
      target,
      vars: vars,
      logger: context.logger,
      fileConflictResolution: FileConflictResolution.overwrite,
    );
    // Post-generation hook
    await generator.hooks.postGen(vars: vars);

    // Update context.vars if needed
    context.vars = {
      ...context.vars,
      'features': capitalizedFeatures,
    };
  }
}
