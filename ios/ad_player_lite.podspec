Pod::Spec.new do |s|
  s.name             = 'ad_player_lite'
  s.version          = '0.1.0'
  s.summary          = 'Flutter wrapper for AdPlayerLite'
  s.description      = 'Flutter plugin bridging AdPlayerLite XCFramework'
  s.homepage         = 'https://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'You' => 'you@example.com' }
  s.source           = { :path => '.' }

  s.source_files     = 'ad_player_lite/Sources/ad_player_lite/**/*.swift'
  s.ios.deployment_target = '15.0'
  # This plugin is SPM-only on iOS: AdPlayerLite and DisplayAds are distributed
  # via Swift Package Manager (see ad_player_lite/Package.swift), not CocoaPods.
  # This podspec exists only because Flutter tooling expects one.
  raise <<~MSG
    ad_player_lite requires Swift Package Manager on iOS.
    Enable it with:  flutter config --enable-swift-package-manager
    then run:        flutter clean && flutter run
  MSG
  s.static_framework = false

  s.dependency 'Flutter'
  s.dependency 'GoogleAds-IMA-iOS-SDK'

  s.resource_bundles = { 'ad_player_lite_privacy' => ['ad_player_lite/Sources/ad_player_lite/PrivacyInfo.xcprivacy'] }
end
