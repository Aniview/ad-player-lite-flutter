import 'package:flutter/foundation.dart';

class ProfilesData {
  final String pubId;
  final String tagId;

  const ProfilesData({
    required this.pubId,
    required this.tagId,
  });

  static const ford = ProfilesData(
    pubId: "609a943be65f6b2a0c3ffbe5",
    tagId: "63fc78e436e14ce9ad0f5a66",
  );

  static const dailyHunt = ProfilesData(
    pubId: "655b78633181f4603178b4568",
    tagId: "69a85c4cf0207bb55009bba7",
  );
}