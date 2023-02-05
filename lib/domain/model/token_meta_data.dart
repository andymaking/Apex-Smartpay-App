import 'package:hive/hive.dart';

part 'token_meta_data.g.dart';

@HiveType(typeId: 99)
class TokenMetaData {
  @HiveField(0)
  String token;
  @HiveField(1)
  String userFirstName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String userId;
  @HiveField(4)
  double lastTimeStored;

  TokenMetaData(
    this.token,
    this.userFirstName,
    this.email,
    this.userId,
      this.lastTimeStored
  );

  @override
  String toString() {
    return 'TokenMetaData{token: $token, full_name: $userFirstName, email: $email'
        'id: $userId,lastTimeStored: $lastTimeStored,}';
  }
}
