import 'package:flutter/material.dart';

class ProfileService extends ChangeNotifier {
  static final ProfileService _instance = ProfileService._internal();
  factory ProfileService() => _instance;
  ProfileService._internal();

  String _profileImageUrl = 'https://i.pravatar.cc/150?u=johndoe'; // Default image

  String get profileImageUrl => _profileImageUrl;

  void setProfileImage(String url) {
    _profileImageUrl = url;
    notifyListeners();
  }
}
