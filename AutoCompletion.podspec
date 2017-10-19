Pod::Spec.new do |s|
s.name         = "AutoCompletion"
s.version      = "1.2.1"
s.summary      = "Text auto completion framework."
s.description  = "Library can be used via cocoapods in any project."
s.homepage     = "https://github.com/3pillarlabs/ios-autocomplete/tree/AutoCompleteFramework"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "Bogdan Todea-Cristea" => "bogdan.todea@3pillarglobal.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/3pillarlabs/ios-autocomplete.git", :tag => "#{s.version}" }
s.source_files  = "Framework/AutoCompletion/AutoCompletion", "Framework/AutoCompletion/AutoCompletion/**/*.{h,m}"
s.exclude_files = "Classes/Exclude"
end
