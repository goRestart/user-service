// swift-tools-version:4.0

import PackageDescription

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
    .package(url: "https://7c97062862d0720b759ca3f6bc253dc7c6730e9d:x-oauth-basic@github.com/skyweb07/core-service.git", .branch("develop"))
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
