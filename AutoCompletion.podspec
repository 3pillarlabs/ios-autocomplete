Pod::Spec.new do |s|
s.name         = "AutoCompletion"
s.version      = "1.2.1"
s.summary      = "Autocomplete textfield."
s.description  = "A framework which provides text field suggestions as a dropdown list. It is available with iOS 9 and later, Objective-C or Swift."
s.homepage     = "https://github.com/3pillarlabs/ios-autocomplete"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "Bogdan Todea-Cristea" => "bogdan.todea@3pillarglobal.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/3pillarlabs/ios-autocomplete.git", :tag => "#{s.version}" }
s.source_files  = "Framework/AutoCompletion/AutoCompletion", "Framework/AutoCompletion/AutoCompletion/**/*.{h,m}"
end
