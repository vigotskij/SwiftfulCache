# SwiftfulCache

[![Swift 6](https://img.shields.io/badge/Swift-6-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2013+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT%20%2B%20AI%20Restriction-lightgrey.svg)](LICENSE)

SwiftfulCache is a lightweight wrapper around `NSCache` that adds expiration and optional disk persistence for `Codable` types.

## Features

- In-memory caching backed by `NSCache`
- Configurable cache lifetime (expiration)
- Configurable maximum number of cached values
- Optional JSON persistence for `Codable` key/value pairs
- Easy API with `set`, `get`, `remove`, `getKeys`, and subscript support
- No external dependencies

## Requirements

- Swift 6+
- iOS 18.0+

## Installation

### Swift Package Manager

Add SwiftfulCache in Xcode:

1. Go to **File > Add Package Dependencies...**
2. Use the repository URL:

   ```
   https://github.com/vigotskij/SwiftfulCache.git
   ```

3. Select your preferred version rule and add the package.

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/vigotskij/SwiftfulCache.git", from: "0.1.0")
]
```

Then add `"SwiftfulCache"` to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: ["SwiftfulCache"]
)
```

## Quick Start

```swift
import SwiftfulCache

let cache = Cache<String, String>(
    cacheLifetime: 3600,      // 1 hour
    maximumCachedValues: 100
)

cache.setValue("Hello", forKey: "greeting")
let value = cache.getValue(forKey: "greeting") as? String

cache["greeting"] = "Hi"
let greeting = cache["greeting"] as? String

cache.removeValue(forKey: "greeting")
cache.clearVolatile()
```

## Persistence

If `Key` and `Value` conform to `Codable`, the same cache can persist data to disk and load it back:

```swift
let cache = Cache<String, MyCodableModel>()
cache.setValue(model, forKey: "user_profile")

let persistResult = cache.persist(withName: "user_cache", using: .default)
let loadResult = cache.load(withName: "user_cache", using: .default)
let clearResult = cache.clearPersistence(withName: "user_cache", using: .default)
```

Persistence uses the system caches directory by default.

## Protocol-based Usage

You can work against the protocols when you want to abstract behavior:

```swift
let volatileCache: VolatileCacheable = Cache<String, YourObject>()
let persistentCache: PersistentCacheable = Cache<String, YourCodableObject>()
```

## References

- Inspired by [Caching in Swift by John Sundell](https://www.swiftbysundell.com/articles/caching-in-swift/)
- Apple documentation:
  - [NSCache](https://developer.apple.com/documentation/foundation/nscache)
  - [FileManager](https://developer.apple.com/documentation/foundation/filemanager)

## Author

[Boris Sortino](https://linkedin.com/in/bsortino/)

## License

SwiftfulCache is available under the MIT license with an additional restriction prohibiting use for AI/ML training. See [LICENSE](LICENSE) for full details.
