enum AdType { video, display }

class AdConfig {
  final String label;
  final AdType type;
  final String pubId;
  final String tagId;

  const AdConfig({
    required this.label,
    required this.type,
    required this.pubId,
    required this.tagId,
  });
}

class AdConfigs {
  static const video = AdConfig(
    label: "Video",
    type: AdType.video,
    pubId: "609a943be65f6b2a0c3ffbe5",
    tagId: "63fc78e436e14ce9ad0f5a66",
  );

  static const displayGam = AdConfig(
    label: "Display",
    type: AdType.display,
    pubId: "565c56d3181f46bd608b459a",
    tagId: "6a9a8c2563d0adbe8f05efd8",
  );

  static const instreamSimple = AdConfig(
    label: "Aniview IS + Simple",
    type: AdType.video,
    pubId: "61235240ea13f3415e2ab496",
    tagId: "673ef06d4e7cf2996c0fba04",
  );

  static const instreamIma = AdConfig(
    label: "Aniview IS + IMA",
    type: AdType.video,
    pubId: "61235240ea13f3415e2ab496",
    tagId: "673efde0b3aaf60c3300af79",
  );

  static const outstreamLongVideo = AdConfig(
    label: "Aniview OS + Long Video",
    type: AdType.video,
    pubId: "61235240ea13f3415e2ab496",
    tagId: "673220403d68bf7004069617",
  );

  static const all = <AdConfig>[
    video,
    displayGam,
    instreamSimple,
    instreamIma,
    outstreamLongVideo,
  ];
}
