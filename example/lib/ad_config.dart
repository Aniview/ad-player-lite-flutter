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

  static const all = <AdConfig>[
    video,
    displayGam,
  ];
}
