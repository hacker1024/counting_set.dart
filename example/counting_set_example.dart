import 'dart:io';

import 'package:counting_set/counting_set.dart';

/// A simple REPL that allows adding/removing/listing values to/from/of a
/// [CountingHashSet].
///
/// Commands:
///   - add <text> | Adds <text> to the set
///   - rem <text> | Removes <text> from the set
///   - lst        | Lists values and counts in the set
///   - bye        | Ends the program.
void main() {
  final set = CountingHashSet<String>();
  repl:
  // ignore: literal_only_boolean_expressions
  while (true) {
    stdout
        .writeln('> Enter a command: "add <text>", "rem <text>", "lst", "bye"');
    stdout.write('> ');

    final command = stdin.readLineSync()?.trim();
    void invalidCommand() {
      stderr.writeln('Invalid command.');
      stdout.writeln();
    }

    if (command == null || command.length < 3) {
      invalidCommand();
      continue;
    }

    final action = command.substring(0, 3);
    final argument = command.substring(3).trim();
    switch (action) {
      case 'add':
        set.add(argument);
        break;
      case 'rem':
        set.remove(argument);
        break;
      case 'lst':
        stdout.writeln(set);
        set.counts.forEach((key, value) => stdout.writeln('$key: $value'));
        break;
      case 'bye':
        break repl;
      default:
        invalidCommand();
        continue repl;
    }
    stdout.writeln();
  }
}
