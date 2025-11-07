import 'package:hive/hive.dart';

class User {
  final String id;
  final String name;
  final String imageUrl;
  final int age;
  final String email;
  const User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.email,
  });
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;
  @override
  User read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final imageUrl = reader.readString();
    final email = reader.readString();
    final age = reader.readInt();

    return User(id: id, name: name, imageUrl: imageUrl, email: email, age: age);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.email);
    writer.writeInt(obj.age);
  }
}
