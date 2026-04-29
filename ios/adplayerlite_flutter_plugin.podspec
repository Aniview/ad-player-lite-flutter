Pod::Spec.new do |s|
  s.name             = 'adplayerlite_flutter_plugin'
  s.version          = '0.0.1'
  s.summary          = 'Flutter wrapper for AdPlayerLite'
  s.description      = 'Flutter plugin bridging AdPlayerLite XCFramework'
  s.homepage         = 'https://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'You' => 'you@example.com' }
  s.source           = { :path => '.' }

  s.source_files     = 'Classes/**/*'
  s.ios.deployment_target = '13.0'
  s.vendored_frameworks = 'AdPlayerLite.xcframework'
  s.static_framework = false
  
  s.dependency 'Flutter'

  # Required dependency
  s.dependency 'GoogleAds-IMA-iOS-SDK'
end
