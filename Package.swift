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
    .package(url: "https://github.com/vapor/validation-provider.git", .upToNextMajor(from: "1.2.0"))
    ],
  targets: [
    .target(name: "App", dependencies: ["Vapor", "FluentProvider", "PostgreSQLProvider", "ValidationProvider"],
            exclude: [
              "Config",
              "Public",
              "Resources",
              ]),
    .target(name: "Run", dependencies: ["App"]),
  ]
)

