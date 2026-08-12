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
  s.vendored_frameworks = 'AdPlayerLite.xcframework'
  s.static_framework = false

  s.dependency 'Flutter'
  s.dependency 'GoogleAds-IMA-iOS-SDK'

  s.resource_bundles = { 'ad_player_lite_privacy' => ['ad_player_lite/Sources/ad_player_lite/PrivacyInfo.xcprivacy'] }
end
