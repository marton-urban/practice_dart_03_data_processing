import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart totals.dart <inputFile.csv>');
    exit(1);
  }
  final inputFile = arguments.first;
  final lines = File(inputFile).readAsLinesSync();

  final durationByTag = {};
  var totalDuration = 0.0;
  lines.removeAt(0);

  for (var line in lines) {
    final values = line.split(',');
    var duration = double.parse(values[3].replaceAll('"', ''));
    final tag = values[5].replaceAll('"', '');
    if (durationByTag[tag] == null) {
      durationByTag[tag] = duration;
    } else {
      durationByTag[tag] += duration;
    }
    totalDuration += duration;
  }
  for (var entry in durationByTag.entries) {
    print(
        '${entry.key == '' ? 'Unallocated' : entry.key}: ${entry.value.toStringAsFixed(1)}h');
  }
  print('');
  print('Total for all tags: ${totalDuration.toStringAsFixed(1)}h');
}
