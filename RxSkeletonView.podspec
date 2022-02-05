#
# Be sure to run `pod lib lint RxSkeletonView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxSkeletonView'
  s.version          = '0.0.1'
  s.summary          = 'A short description of RxSkeletonView.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.homepage         = 'https://github.com/yangKJ/RxSkeletonView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Condy' => 'ykj310@126.com' }
  s.source           = { :git => 'https://github.com/yangKJ/RxSkeletonView.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.swift_version    = '5.0'
  s.requires_arc     = true
  s.static_framework = true
  s.module_name      = 'RxSkeletonView'

  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'RxDataSources'
  s.dependency 'SkeletonView'
  
  s.source_files = 'RxSkeletonView/Classes/**/*'
  
end
