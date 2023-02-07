// import 'package:Smartpay/data/cache/user.cache.dart';
// import 'package:Smartpay/data/core/table_constants.dart';
// import 'package:Smartpay/domain/model/token_meta_data.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class UserCacheImpl extends UserCache {
//
//   @override
//   Future<TokenMetaData?> getTokenMetaData() async {
//     final box = await Hive.openBox<TokenMetaData>(DbTable.TOKEN_TABLE_NAME);
//     if (box.values.isEmpty) {
//       return null;
//     } else {
//       final data = box.values.toList();
//       return data.last;
//     }
//   }
//
//   @override
//   Future<void> saveTokenMetaData(TokenMetaData tokenMetaData) async {
//     var box = await Hive.openBox<TokenMetaData>(DbTable.TOKEN_TABLE_NAME);
//     await box.clear();
//     box.add(tokenMetaData);
//   }
//
//   // @override
//   // Future<void> saveUserLogin(User user) async {
//   //   var box = await Hive.openBox<User>(DbTable.USER_TABLE_NAME);
//   //   await box.clear();
//   //   box.add(user);
//   // }
//
//   @override
//   Future<void> updateUserFirstTime(bool status) async {
//     var box = await Hive.openBox<bool>(DbTable.APP_FIRST_TIME_TABLE_NAME);
//     box.add(status);
//   }
//
//   // @override
//   // Future<void> clearUserData() async {
//   //   var userBox = await Hive.openBox<User>(DbTable.USER_TABLE_NAME);
//   //   await userBox.clear();
//   //   var tokenBox = await Hive.openBox<TokenMetaData>(DbTable.TOKEN_TABLE_NAME);
//   //   await tokenBox.clear();
//   // }
// }
