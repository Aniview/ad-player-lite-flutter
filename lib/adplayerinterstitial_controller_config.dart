import 'package:flutter/foundation.dart';

class InterstitialConfig {
  final double noAdTimeout;
  final double? stalledVideoTimeout;
  final bool showCloseButtonAfterAdDuration;

  const InterstitialConfig({
    required this.noAdTimeout,
    this.stalledVideoTimeout,
    required this.showCloseButtonAfterAdDuration,
  });
}

extension InterstitialConfigMapper on InterstitialConfig {
  Map<String, dynamic> toMap() {
    return {
      'noAdTimeout': noAdTimeout,
      'stalledVideoTimeout': stalledVideoTimeout,
      'showCloseButtonAfterAdDuration': showCloseButtonAfterAdDuration,
    };
  }
}