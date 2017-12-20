import Foundation
import Vapor

struct CreatePasswordHashTask {

  private let hasher: HashProtocol
  
  init(hasher: HashProtocol) {
    self.hasher = hasher
  }
  
  func create(with password: String, salt: String = UUID().uuidString) throws -> (hash: String, salt: String) {
    let hash = try hasher.make(
      self.hash(for: salt, and: password)
    ).makeString()
    return (hash: hash, salt: salt)
  }
  
  func hash(for salt: String, and password: String) -> String {
    return salt + password
  }
}
