#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'ironsource_flutter_ads'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin that uses native platform views to show IronSource banner and interstitial ads!'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://www.cntinteractive.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'CNT Interactive' => 'info@cntinteractive.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'IronSourceSDK'
  s.dependency 'IronSourceAdMobAdapter'
  s.dependency 'IronSourceFacebookAdapter'
  s.dependency 'IronSourceInMobiAdapter'

  s.static_framework = true
  s.ios.deployment_target = '9.0'
end

