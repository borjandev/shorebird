import 'package:mason_logger/mason_logger.dart';
import 'package:shorebird_cli/src/command.dart';
import 'package:shorebird_cli/src/logger.dart';
import 'package:shorebird_cli/src/shorebird_flutter.dart';

/// {@template flutter_versions_list_command}
/// `shorebird flutter versions list`
/// List available Flutter versions.
/// {@endtemplate}
class FlutterVersionsListCommand extends ShorebirdCommand {
  /// {@macro flutter_versions_list_command}
  FlutterVersionsListCommand();

  @override
  String get description => 'List available Flutter versions.';

  @override
  String get name => 'list';

  @override
  Future<int> run() async {
    final progress = logger.progress('Fetching Flutter versions');
    final List<String> versions;
    try {
      versions = await shorebirdFlutter.getVersions();
      progress.complete();
    } catch (error) {
      progress.fail('Failed to fetch Flutter versions.');
      logger.err('$error');
      return ExitCode.software.code;
    }

    logger.info('📦 Flutter Versions');
    for (final version in versions.reversed) {
      logger.info(version);
    }
    return ExitCode.success.code;
  }
}
