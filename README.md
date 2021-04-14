# TakeHome

### Frameworks used
Alamofire - for fetching podcasts from the given API
Kingfisher - for setting UIImages by URL for podcasts easily

### Architecture
This app uses MVC app architecture because this architecture allows to create an application in the fastest way.

### Approaches
- Сustom data model (Debouncer) was created during debounce implementation to handle debounce events easily
- PodcastCell (TableViewCell) is implemented with .xib with a purpose of not overloading main.storyboard
- Scenes have been removed
- Pagination and few unit tests are included

### Installation
Checkout the repo, just do 
```
pod install
```
and open and run the .xcworkspace file