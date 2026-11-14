# Tapp-Adjust iOS SDK

The Tapp + Adjust iOS package. Swift Package Manager is the primary install path.

## Swift Package Manager

In Xcode, choose **File → Add Packages…**, enter `https://github.com/tapp-so/Tapp-Adjust-iOS.git`, and add the **TappAdjust** product.

For a `Package.swift` manifest, add the package dependency and product to your target:

```swift
dependencies: [
    .package(url: "https://github.com/tapp-so/Tapp-Adjust-iOS.git", from: "1.1.27")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "TappAdjust", package: "Tapp-Adjust-iOS")
        ]
    )
]
```

## CocoaPods

CocoaPods releases after 1.1.27 are published only to [tapp-so/Specs](https://github.com/tapp-so/Specs).

Add both source lines at the top of your Podfile, in this order, then the pod:

```ruby
source 'https://github.com/tapp-so/Specs.git'   # must come first
source 'https://cdn.cocoapods.org/'

pod 'Tapp-Adjust'
```

Both source lines are required, in this order. Once a Podfile declares any source, CocoaPods stops adding trunk automatically, so the CDN line is needed for other pods (including Adjust).

Licensed under [MIT](LICENSE.md).
