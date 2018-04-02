# RxRestClient

[![CI Status](http://img.shields.io/travis/stdevteam/RxRestClient.svg?style=flat)](https://travis-ci.org/stdevteam/RxRestClient)
[![Version](https://img.shields.io/cocoapods/v/RxRestClient.svg?style=flat)](http://cocoapods.org/pods/RxRestClient)
[![License](https://img.shields.io/cocoapods/l/RxRestClient.svg?style=flat)](http://cocoapods.org/pods/RxRestClient)
[![Platform](https://img.shields.io/cocoapods/p/RxRestClient.svg?style=flat)](http://cocoapods.org/pods/RxRestClient)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.3+
* Swift 4.x
* Xcode 9+

## Installation

RxRestClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxRestClient'
```

## Features

* Simple way to do requests
* Simple way to have response state in reactive way
* Ability to customization
* Retry on any error
* Handle network reachability status
* Retry on become reachable
* Ability to use absalute and relative urls
* _more coming soon_

## How to use

First of all you need to create `struct` of your response state and implement `ResponseState` protocol.

```swift
struct RepositoriesState: ResponseState {

    var state: BaseState?
    var data: [Repository]?

    private init() {
        state = nil
    }

    init(state: BaseState) {
        self.state = state
    }

    init(response: (HTTPURLResponse, String)) {
        if response.0.statusCode == 200 {
            self.data = try? RepositoryResponse(JSONString: response.1).items
        }
    }

    static let empty = RepositoriesState()
}
```

Than you can do the request to get repositories:

```swift
import RxSwift
import RxRestClient

protocol RepositoriesServiceProtocol {
    func get(search: String) -> Observable<RepositoriesState>
}

class RepositoriesService: RepositoriesServiceProtocol {

    private let client = RxRestClient()

    func get(search: String) -> Observable<RepositoriesState> {
        return client.get("https://api.github.com/search/repositories", query: ["q": search])
    }
}

```

In order to customize client you can use `RxRestClientOptions`:

```swift
var options = RxRestClientOptions.default
options.addHeader(key: "x-apikey", value: "<API_KEY>")
client = RxRestClient(baseUrl: <BASE _URL>), options: options)
```

### Relative vs absalute url

In order to use relative url you need to give `<BASE_URL>` when initializing client object.

```swift
let client = RxRestClient(baseURL: <BASE_URL>)
```

When calling any request you can provide either `String` endpoint or absalute `URL`. If you will `String` it will be appended to `baseURL`.

```swift
client.get("rest/contacts")
```

If `baseURL` is `nil` than it will try to convert provided `String` to `URL`.

In order to use absalute url even when your client has `baseURL` you can provide `URL` like this:

```swift
if let url = URL(string: "https://api.github.com/search/repositories") {}
    client.get(url: url, query: ["q": search])
}
```

## Author

Tigran Hambardzumyan, tigran@stdevmail.com

## Support

Feel free to [open issuses](https://github.com/stdevteam/RxRestClient/issues/new) with any suggestions, bug reports, feature requests, questions.

## Let us know!

We’d be really happy if you sent us links to your projects where you use our component. Just send an email to developer@stdevmail.com and do let us know if you have any questions or suggestion.

## License

RxRestClient is available under the MIT license. See the LICENSE file for more info.