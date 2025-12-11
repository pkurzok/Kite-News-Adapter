# Kite News Adapter

This is very early work on a Swift Client for [Kagi News](https://news.kagi.com) following their [Open API Spec](https://news.kagi.com/api/openapi). The goal is obviously to build an alternative SwiftUI client for Kagi News someday.


## Installation
### Swift Package Manager

#### Option 1: Add via Xcode

1. In Xcode, go to **File → Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/pkurzok/Kite-News-Adapter`
3. Select the version rule you prefer
4. Click **Add Package**

#### Option 2: Reference the Main Branch

To always use the latest development version from the main branch, add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/pkurzok/Kite-News-Adapter.git", branch: "main")
]
```

## Usage
The adapter currently provides three main functions for accessing Kagi News:

```swift
import KiteNewsAdapter

let adapter = KiteNewsAdapter()

// 1. Fetch the latest news badge (summary information)
let badge = try await adapter.fetchLatestNewsBadge()

// 2. Fetch all available news categories
let categories = try await adapter.fetchLatestCategories()

// 3. Fetch stories for a specific category
let stories = try await adapter.fetchStories(forCategory: category.id)
```
