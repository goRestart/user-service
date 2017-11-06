import Vapor
@testable import App

extension Droplet {
  static func testable() throws -> Droplet {
    let droplet = InMemoryDroplet.droplet
    droplet.config.arguments = ["vapor", "--env=test"]
    return droplet
  }
}

private final class InMemoryDroplet {
  static let droplet = resolver.application
}
