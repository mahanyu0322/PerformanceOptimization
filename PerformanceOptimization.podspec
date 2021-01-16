Pod::Spec.new do |spec|
  
  spec.name         = "PerformanceOptimization"
  spec.version      = "0.0.3"
  spec.summary      = "This is an open source framework that monitors crashes and skips APP exit and monitor interface freezes"

  spec.homepage     = "https://github.com/mahongliang0322/PerformanceOptimization"

  spec.license      = "MIT"

  spec.author             = { "马洪亮" => "656691922@qq.com" }

  spec.source       = { :git => "https://github.com/mahongliang0322/PerformanceOptimization.git", :tag => "#{spec.version}" }

  spec.source_files  = "PerformanceOptimization/**/*.{h,m}"
  
  spec.platform     = :ios, "8.0"
  
  spec.frameworks = "UIKit", "Foundation"


end
