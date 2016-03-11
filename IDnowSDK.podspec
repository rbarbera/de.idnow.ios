Pod::Spec.new do |s|
  s.name         = "IDnowSDK"
  s.version      = "2.0.0"
  s.summary      = "IDnowSDK for iOS"
  s.description  = "With IDnow, personal identification checks and personal signatures have finally arrived in the digital world. We offer companies and institutions innovative platform-specific solutions that guarantee the safe and legally sound verification of customers, clients and contractual partners."
  s.homepage     = "http://www.idnow.eu/developers"
  s.license      = 'Comercial'

  s.authors       =  {'Armin Bauer' => 'mail@arminbauer.com', 'Matthias Redlin' => '@macmacen' }
  
  s.ios.platform          = :ios, '7.0'
  s.ios.deployment_target = '7.0'

  s.source       = { 
    :git => "https://github.com/rbarbera/de.idnow.ios.git", 
    :tag => "de.idnow.ios-2.0.0-RC.3" 
  }
  s.ios.source_files        = 'idnow-sdk/include/*.h'
  s.ios.public_header_files = 'idnow-sdk/include/*.h'
  s.ios.vendored_libraries  = 'idnow-sdk/libidnow-sdk-universal.a'
  s.resources               = 'idnow-sdk/resources/*'

  s.ios.dependency 'Masonry', '~> 0.6.2'
  s.ios.dependency 'SocketRocket', '~> 0.4'
  s.ios.dependency 'AFNetworking', '~> 2.6.0'
  s.ios.dependency 'UIAlertView+Blocks', '~> 0.8.1'
  s.ios.dependency 'OpenTok', '~> 2.6.1'

  s.frameworks = 'WebKit', 'Accelerate'
  s.libraries = 'z'

  s.requires_arc = true
end