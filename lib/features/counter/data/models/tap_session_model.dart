import 'package:hive/hive.dart';

///records the [TapSession]where taps in given time, total time and data time of that tap
class TapSession {
  final int totalTaps;
  final int totalTime;
  final DateTime dateTime;
  const TapSession({
    required this.totalTaps,
    required this.totalTime,
    required this.dateTime,
  });
}

///[TypeAdapter] for [TapSession]
class TapSessionAdapter extends TypeAdapter<TapSession> {
  @override
  final int typeId = 0;
  @override
  TapSession read(BinaryReader reader) {
    final totalTaps = reader.readInt();
    final totalTime = reader.readInt();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    return TapSession(
      totalTaps: totalTaps,
      totalTime: totalTime,
      dateTime: dateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TapSession obj) {
    writer.writeInt(obj.totalTaps);
    writer.writeInt(obj.totalTime);
    writer.writeInt(obj.dateTime.millisecondsSinceEpoch);
  }
}
