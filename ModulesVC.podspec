Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '15.0'
s.name = "ModulesVC"
s.summary = "Module Selection View Controller using CollectionView"
#s.requires_arc = true

# 2
s.version          = ENV['LIB_VERSION'] || '1.0' #fallback to major version

# 3
s.license = { :type => "GPL-3.0", :file => "LICENSE"}

# 4 - Replace with your name and e-mail address
s.author = { "Justin Kumpe" => "helpdesk@kumpeapps.com" }
# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/kumpeapps/ModulesVC.git"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => 'https://github.com/kumpeapps/ModulesVC.git', :tag => 
"#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'SwiftMessages'
s.dependency 'CollectionViewCenteredFlowLayout'
s.dependency 'Haptico'
s.dependency 'DeviceKit'
s.dependency 'FetchedResultsControllerCollectionViewUpdater'
s.dependency 'Kingfisher'
s.dependency 'BadgeSwift'

# 8
s.source_files = "ModulesVC/**/*.{swift,storyboard,xib,png}"

# 9
#s.resources = "ModulesVC/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5"

end
