Pod::Spec.new do |s|
s.name        = 'ACTreeMenu'
s.version     = '1.0.0'
s.authors     = { 'iAllenChen' => '373381941@qq.com' }
s.homepage    = 'https://github.com/iAllenC/ACTreeMenu'
s.summary     = 'a submenu based on UITableView'
s.source      = { :git => 'https://github.com/liugangios/IFMMenu.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '7.0'
s.requires_arc = true
s.source_files = 'IFMMenu'
s.public_header_files = 'IFMMenu/*.h'

s.ios.deployment_target = '8.0'
end


