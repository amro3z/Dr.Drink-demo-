import 'dart:convert';
import 'dart:developer';
import 'package:dr_drink/logic/tracker.dart';
import 'package:dr_drink/logic/profile.dart';
import 'package:dr_drink/logic/history.dart';
import 'package:dr_drink/logic/account.dart';

import 'data.dart';

class MyUser {
  static final MyUser _instance = MyUser._internal();

  factory MyUser({
    required Data data,
    Tracker? tracker,
    Profile? profile,
    History? history,
    Account? account,
  }) {
    _instance.data = data;
    _instance.tracker = tracker ?? Tracker();
    _instance.profile = profile ?? Profile();
    _instance.history = history ?? History();
    _instance.account = account ?? Account();
    return _instance;
  }

  MyUser._internal();

  static MyUser get instance => _instance;

  Data data = Data();
  Tracker tracker = Tracker();
  Profile profile = Profile();
  History history = History();
  Account account = Account();

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'tracker': json.encode(tracker.toMap()),
      'profile': json.encode(profile.toMap()),
      'history': json.encode(history.toMap()),
      'account': json.encode(account.toMap()),
    };
  }

  // Create a MyUser instance from a map
  factory MyUser.fromMap(Map<String, dynamic> map) {
    log("Creating MyUser from map...");
    return MyUser(
      data: Data.fromMap(map['data']),
      tracker: Tracker.fromMap(json.decode(map['tracker'])),
      profile: Profile.fromMap(json.decode(map['profile'])),
      history: History.fromMap(json.decode(map['history'])),
      account: Account.fromMap(json.decode(map['account'])),
    );
  }
}