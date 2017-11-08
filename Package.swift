// swift-tools-version:4.0

import Foundation
import PackageDescription

// MARK: - Helper to get environment variables from system

enum Env {
  static func get(_ name: String) -> String? {
    guard let out = getenv(name) else { return nil }
    return String(validatingUTF8: out)
  }
}

let githubToken = Env.get("GITHUB_TOKEN")!

let package = Package(
  name: "user-service",
  products: [
    .library(name: "App", targets: ["App"]),
    .executable(name: "Run", targets: ["Run"])
  ],
  dependencies: [
    .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.3.0")),
    .package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/vapor-community/postgresql-provider.git", .upToNextMajor(from: "2.1.0")),
    .package(url: "https://github.com/vapor/validation-provider.git", .upToNextMajor(from: "1.2.0")),
    .package(url: "https://\(githubToken):x-oauth-basic@github.com/skyweb07/core-service.git", .branch("develop"))
    ],
  targets: [
    .target(name: "App", dependencies: ["Vapor", "FluentProvider", "PostgreSQLProvider", "ValidationProvider", "CoreService"],
            exclude: [
              "Config",
              "Public",
              "Resources",
              ]),
    .target(name: "Run", dependencies: ["App"]),
    .testTarget(name: "AppTests", dependencies: ["App", "Testing", "CoreTesting"])
  ]
)
