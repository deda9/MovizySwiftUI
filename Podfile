use_frameworks!
workspace 'MovizySwiftUI'


def network_pods
    pod 'Alamofire'
end

target 'MovizySwiftUI' do
  network_pods
  target 'MovizySwiftUITests' do
    inherit! :search_paths
  end
  
  target 'MovizySwiftUIUITests' do
  end
end

target 'Network' do project 'Network/Network'
  network_pods
  target :NetworkTests do
  end
end
