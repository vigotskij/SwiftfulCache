# SwiftfulCache

[![Swift 6](https://img.shields.io/badge/Swift-6-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2018+-blue.svg)](https://developer.apple.com/ios/)
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

## CI and Releases

This repository uses GitHub Actions for automation:

- On each PR, CI runs the shared checks:
  - `yarn lane:lint` (strict concurrency + warnings-as-errors)
  - `yarn lane:test`
- On push to `main`, the release workflow runs the same checks and then runs `semantic-release` (executed with Yarn).

These shared commands are intentionally "lane-like" so they can be reused later from Fastlane lanes.

Security hardening applied in CI workflows:

- Least-privilege GitHub token permissions on PR workflows
- JavaScript actions pinned to immutable commit SHAs
- Read-only checkout credentials on PR workflows
- Dependency installs with script execution disabled

Release behavior from commit titles:

- `feat:` -> minor release
- `fix:`, `perf:`, `chore:` -> patch release
- `BREAKING CHANGE` or `!` after type/scope -> major release
- Add `(no-release)` anywhere in the commit message to skip release for that commit

Examples:

- `chore: update docs` -> patch release
- `chore: update docs (no-release)` -> no release

### Release workflow secrets (GitHub)

The release job uses a **fine-grained personal access token** and **SSH commit signing** so pushes to `main` satisfy typical rules (signed commits, automation not blocked by default `GITHUB_TOKEN` limits).

Add these in **Repository → Settings → Secrets and variables → Actions**:

| Secret | Purpose |
|--------|---------|
| `RELEASE_TOKEN` | Fine-grained PAT for this repo: **Contents** read/write, **Metadata** read. Used for checkout, `semantic-release` GitHub plugin, and pushing changelog commits. |
| `SSH_RELEASE_SIGNING` | Full private key file (OpenSSH format) for the **same SSH key** you added under GitHub → *SSH keys* with **type Signing**. Used only in the release step so changelog commits are verified. |

Release commits use a fixed identity in `.github/workflows/release.yml` (`user.name` / `user.email`). Change those lines later if you want a different author or to wire secrets.

The signing key must match the **Signing** key on your GitHub account, or commits will not show as verified.

## References

- Inspired by [Caching in Swift by John Sundell](https://www.swiftbysundell.com/articles/caching-in-swift/)
- Apple documentation:
  - [NSCache](https://developer.apple.com/documentation/foundation/nscache)
  - [FileManager](https://developer.apple.com/documentation/foundation/filemanager)

## Author

[Boris Sortino](https://linkedin.com/in/bsortino/)

## License

SwiftfulCache is available under the MIT license with an additional restriction prohibiting use for AI/ML training. See [LICENSE](LICENSE) for full details.
