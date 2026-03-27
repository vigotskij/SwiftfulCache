# SwiftfulCache

[![Swift 6](https://img.shields.io/badge/Swift-6-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2013+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT%20%2B%20AI%20Restriction-lightgrey.svg)](LICENSE)

A lightweight Swift wrapper around `NSCache` that provides both volatile (in-memory) and persistent (disk-backed) caching with expiration support.

## Features

- **Volatile cache** — in-memory caching backed by `NSCache` with automatic eviction and configurable limits
- **Persistent cache** — JSON-based disk persistence for `Codable` types
- **Expiration** — configurable cache lifetime with automatic cleanup of stale entries
- **Subscript access** — read and write cache entries with `cache[key]` syntax
- **Pure Swift** — no external dependencies

## Installation

### Swift Package Manager

Add SwiftfulCache to your project via Xcode:

1. Go to **File > Add Package Dependencies...**
2. Enter the repository URL:
   ```
   https://github.com/vigotskij/SwiftfulCache.git
   ```
3. Select your desired version rule and add the package.

Or add it directly to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/vigotskij/SwiftfulCache.git", from: "0.1.0")
]
```

Then add `"SwiftfulCache"` as a dependency of the target that will use it:

```swift
.target(
    name: "YourTarget",
    dependencies: ["SwiftfulCache"]
)
```

## Usage

### Volatile Cache (in-memory)

```swift
import SwiftfulCache

let cache = Cache<String, String>(
    cacheLifetime: 3600,      // 1 hour
    maximumCachedValues: 100
)

// Store a value
cache.setValue("Hello", forKey: "greeting")

// Retrieve a value
let value = cache.getValue(forKey: "greeting") as? String

// Subscript access
cache["greeting"] = "Hi"
let greeting = cache["greeting"] as? String

// Clear all in-memory entries
cache.clearVolatile()
```

### Persistent Cache (disk-backed)

When `Key` and `Value` conform to `Codable`, you get persistence for free:

```swift
let cache = Cache<String, MyCodableModel>()

cache.setValue(model, forKey: "user_profile")

// Persist to disk
cache.persist(withName: "user_cache", using: .default)

// Load from disk
cache.load(withName: "user_cache", using: .default)

// Remove persisted file
cache.clearPersistence(withName: "user_cache", using: .default)
```

## Requirements

- iOS 13.0+
- Swift 6+

## Usage
After that, you can use it importing the framework and initializing a specialized Cache, for example:  
```swift
 class SomeClass {
  // You can use only the RAM Cache
  let volatileCache: VolatileCacheable = Cache<String, YourObject>()
  // or Persistent which includes Volatile
  let persistentCache: PersistentCacheable = Cache<String, YourObject>()
  // or, just the Cache class, which has a few default values on the function signatures.
  // Using the Cache class will load both Volatile and Persistent Cache
  let cache: Cache<String, YourObject> = .init()
 }
 ```

For persistent cache, using the `.cachesDirectory` allows the system to clean the files as its own rules. A valid alternative is to use `.documentsDirectory` which will allow you to store the data, as long as your app exists, by your own terms.

## What is done
* Volatile cache set, get, remove, get keys, and subscript functions
* Persistent cache persist to file and load from file to Volatile cache functions
* Volatile tests for set, get, remove, get keys functions
* Volatile performance tests for set, get, remove and get keys functions
* Persistent parcial tests for both persist and load functions
* Added basic error handling for persist and load functions
* PersistentCacheable full test coverage for persist and load functions
* PersistentCacheable performance tests

# References
This was created inspired by the [work](https://www.swiftbysundell.com/articles/caching-in-swift/) of [John Sundell](https://github.com/JohnSundell).

And also using Apple's related documentation:
- [NSCache](https://developer.apple.com/documentation/foundation/nscache)
- [FileManager](https://developer.apple.com/documentation/foundation/filemanager)## Author

[Boris Sortino](https://linkedin.com/in/bsortino/)

## License

SwiftfulCache is available under the MIT license with an additional restriction prohibiting use for AI/ML training. See the [LICENSE](LICENSE) file for full details.
