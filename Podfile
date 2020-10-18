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


target 'NetworkLayer' do project 'NetworkLayer/NetworkLayer'
  network_pods
  target :NetworkLayerTests do
  end
end


target 'Trailers' do project 'MovizySwiftUI/Trailers/Trailers'
  network_pods
  target :TrailersTests do
  end
end


target 'Search' do project 'MovizySwiftUI/Search/Search'
  network_pods
  target :SearchTests do
  end
end


target 'Movies' do project 'MovizySwiftUI/Movies/Movies'
  network_pods
  target :MoviesTests do
  end
end
