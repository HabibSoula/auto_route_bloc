import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  // Function to execute a command and log its output
  Future<void> executeCommand(
    String command,
    List<String> args, {
    bool isDev = false,
    String? workingDirectory,
  }) async {
    final workingDir = workingDirectory ?? Directory.current.path;
    context.logger.info('Running: $command ${args.join(' ')} in $workingDir');

    final result = await Process.run(
      command,
      args,
      runInShell: true,
      workingDirectory: workingDir,
    );

    if (result.stdout.toString().isNotEmpty) {
      context.logger.info(result.stdout.toString());
    }

    if (result.stderr.toString().isNotEmpty) {
      context.logger.err(result.stderr.toString());
    }

    if (result.exitCode != 0) {
      throw Exception('Command failed: $command ${args.join(' ')}');
    }
  }

  try {
    // Add bloc
    await executeCommand('flutter', ['pub', 'add', 'flutter_bloc']);
    context.logger.info('Successfully added bloc.');

    // Add auto_route
    await executeCommand('flutter', ['pub', 'add', 'auto_route']);
    context.logger.info('Successfully added auto_route.');

    // Activate global auto_route_generator
    await executeCommand(
      'dart',
      ['pub', 'add', 'auto_route_generator'],
    );
    context.logger
        .info('Successfully activated auto_route_generator globally.');

    // Add build_runner as a dev dependency
    await executeCommand(
      'dart',
      ['pub', 'add', 'dev:build_runner'],
    );
    context.logger.info('Successfully added build_runner as a dev dependency.');

    // Determine the parent directory (adjust as needed)
    final parentDir = Directory.current.parent.path;

    // Optional: Verify that the parent directory contains a pubspec.yaml
    final pubspec = File('$parentDir/pubspec.yaml');
    if (!await pubspec.exists()) {
      throw Exception(
          'pubspec.yaml not found in the parent directory: $parentDir');
    }

    // Run build_runner in the parent directory
    await executeCommand(
      'dart',
      ['run', 'build_runner', 'build'],
      workingDirectory: parentDir,
    );
    context.logger.info('build_runner has successfully built.');

    progress.complete('All packages installed and build completed.');
  } catch (e) {
    progress.fail('An error occurred: $e');
  }
}
