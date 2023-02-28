# For trying "Async/await"

### Async/await
Completion Handler(Call back)을 사용하는 것보다 가독성이 향상됨.
Error Handle이 가능하게 됨


**Version**
iOS 15.0 부터 많이 사용되는(?) async 관련 API 지원, 하지만 여전히 많은 API Completion을 통하여 처리.
iOS 13.0(Xcode 13.2)이상 15.0 미만 Version과 Async/await 지원하지 않는 API에서 Async/await을 사용하기위해 **Continuation** 사용 필요

```swift
await withCheckedContinuation { continuation in
    reqeustImageSynchronous(with: fetchedPhotosAsset[index], size: size) { image in
        continuation.resume(returning: image)
    }
}
```

**Unit Test, about Task**
Task { } 테스트하는데 있어서 Combine을 사용해서 다음과 같이 진행했지만, 좋은 방법인지 의문
```swift
class TodayPresenterSpy {
     
    @Published var presentWeatherCalled = false

    func presentWeather(response: AboutToday.TodayWeather.Fetched.Response) {
        presentWeatherCalled = true
    }
}

func test_loadWeather_whenGiveCurrentLocation_shouldCallPresenter() {
    ///given
    sut.presenter = todayPresenterSpy
        
    let promise = expectation(description: "Presenter Be Called")
    todayPresenterSpy.$presentWeatherCalled
        .sink { isCalled in
            if isCalled {
                promise.fulfill()
            }
        }
        .store(in: &cancellableBag)
    ///when
    sut.loadWeather()
    wait(for: [promise], timeout: 1)
    ///then
    XCTAssert(todayPresenterSpy.presentWeatherCalled)
}
```

**Performance**
Async/await이 Suspend를 통하여, (즉, Thread Control을 System이 맡아중요도에 따라 처리하는 방법) Async를 처리하는 것이, GCD보다 퍼포먼스 측면에서 얼마나 유용한지 이해 부족
#### Directory List

    ├── AboutToday
    │   ├── Resources
    │   │   └── Assets.xcassets
    │   │       ├── AccentColor.colorset
    │   │       │   └── Contents.json
    │   │       ├── AppIcon.appiconset
    │   │       │   └── Contents.json
    │   │       └── Contents.json
    │   ├── Sources
    │   │   ├── Entries
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── SceneDIContainer.swift
    │   │   │   └── SceneDelegate.swift
    │   │   ├── Models
    │   │   │   └── Weather.swift
    │   │   ├── Repositories
    │   │   │   ├── PhotosRepository.swift
    │   │   │   ├── WeatherIconRepository.swift
    │   │   │   └── WeatherRepository.swift
    │   │   ├── Scenes
    │   │   │   ├── Map
    │   │   │   │   ├── Annotations
    │   │   │   │   │   └── PhotoAnnotation.swift
    │   │   │   │   ├── DetailMapPresenter.swift
    │   │   │   │   ├── DetailMapRouter.swift
    │   │   │   │   ├── DetailMapViewController.swift
    │   │   │   │   ├── DetailMapnteractor.swift
    │   │   │   │   └── ViewModels
    │   │   │   │       └── PhotosLocation.swift
    │   │   │   ├── Today
    │   │   │   │   ├── TodayInteractor.swift
    │   │   │   │   ├── TodayPresenter.swift
    │   │   │   │   ├── TodayRouter.swift
    │   │   │   │   ├── TodayViewController.swift
    │   │   │   │   ├── ViewModels
    │   │   │   │   │   ├── ListPhotoImages.swift
    │   │   │   │   │   └── WeatherViewModel.swift
    │   │   │   │   └── Views
    │   │   │   │       ├── Cells
    │   │   │   │       │   └── TodayPhotoCell.swift
    │   │   │   │       ├── CurrentLocationView.swift
    │   │   │   │       ├── LocationErrorView.swift
    │   │   │   │       ├── TodayView.swift
    │   │   │   │       └── TodayWeatherView.swift
    │   │   │   ├── ViewController.swift
    │   │   │   └── Weather Detail
    │   │   │       ├── ViewModels
    │   │   │       │   └── WeatherDetail.swift
    │   │   │       ├── Views
    │   │   │       │   └── WeatherDetailView.swift
    │   │   │       ├── WeatherDetailInteractor.swift
    │   │   │       ├── WeatherDetailPresenter.swift
    │   │   │       ├── WeatherDetailRouter.swift
    │   │   │       └── WeatherDetailViewController.swift
    │   │   ├── Service
    │   │   │   ├── Network
    │   │   │   │   ├── APIEndpoints.swift
    │   │   │   │   ├── Endpoint.swift
    │   │   │   │   ├── NetworkAPIConfiguration.swift
    │   │   │   │   ├── NetworkDataCodableService.swift
    │   │   │   │   ├── NetworkService.swift
    │   │   │   │   └── Requester.swift
    │   │   │   └── Photos
    │   │   │       └── PhotosService.swift
    │   │   ├── Utils
    │   │   │   ├── Extensions
    │   │   │   │   ├── UIColor+Gradient.swift
    │   │   │   │   ├── UIVIew+Corner Radius.swift
    │   │   │   │   └── UIView+Border.swift
    │   │   │   └── UIViewPreview.swift
    │   │   └── Workers
    │   │       ├── PhotosWorker.swift
    │   │       └── WeatherWorker.swift
    │   └── Supportings
    │       ├── Base.lproj
    │       │   └── LaunchScreen.storyboard
    │       ├── ConfidentialKey.xcconfig
    │       ├── Info.plist
    │       └── ar.lproj
    │           └── LaunchScreen.strings
    ├── AboutToday.xcodeproj
    │   ├── project.pbxproj
    │   ├── project.xcworkspace
    │   │   ├── contents.xcworkspacedata
    │   │   ├── xcshareddata
    │   │   │   ├── IDEWorkspaceChecks.plist
    │   │   │   └── swiftpm
    │   │   │       ├── Package.resolved
    │   │   │       └── configuration
    │   │   └── xcuserdata
    │   │       └── doyoung.xcuserdatad
    │   │           └── UserInterfaceState.xcuserstate
    │   ├── xcshareddata
    │   │   └── xcschemes
    │   │       ├── AboutToday - arabic.xcscheme
    │   │       └── AboutToday.xcscheme
    │   └── xcuserdata
    │       └── doyoung.xcuserdatad
    │           ├── xcdebugger
    │           │   └── Breakpoints_v2.xcbkptlist
    │           └── xcschemes
    │               └── xcschememanagement.plist
    ├── AboutTodayTests
    │   ├── Network
    │   │   ├── NetworkCodableServiceTests.swift
    │   │   └── NetworkServiceTests.swift
    │   ├── Scenes
    │   │   ├── DetailMap
    │   │   │   ├── DetailMapInteractor.swift
    │   │   │   ├── DetailMapPresenterTests.swift
    │   │   │   └── DetailViewControllerTests.swift
    │   │   ├── Today
    │   │   │   ├── TodayInteractorTests.swift
    │   │   │   ├── TodayPresenterTests.swift
    │   │   │   └── TodayViewControllerTests.swift
    │   │   └── WeatherDetail
    │   │       ├── WeatherDetailInteractorTests.swift
    │   │       ├── WeatherDetailPresenterTests.swift
    │   │       └── WeatherDetailViewControllerTests.swift
    │   ├── Seeds.swift
    │   └── Worker
    │       └── WeatherWorkerTests.swift
    ├── AboutTodayUITests
    │   ├── AboutTodayUITests.swift
    │   └── AboutTodayUITestsLaunchTests.swift
    └── README.md


