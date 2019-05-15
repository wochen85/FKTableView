Pod::Spec.new do |s|
  s.name             = 'FKTableView'
  s.version          = '1.2.0'
  s.summary          = 'UITableView的友好扩展'
  s.homepage         = 'https://github.com/wochen85/FKTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CHAT' => '312163862@qq.com' }
  s.source           = { :git => 'https://github.com/wochen85/FKTableView.git', :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.dependency 'FKTableCollectionExtensionBase'

  s.source_files = 'FKTableView/FKTableView/Classes/*.{h,m}'

end
