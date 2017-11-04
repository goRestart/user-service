import Foundation
import Vapor

struct CreatePasswordHashTask {

  private let hasher: HashProtocol
  
  init(hasher: HashProtocol) {
    self.hasher = hasher
  }
  
  func create(with password: String) throws -> (hash: String, salt: String) {
    let salt = UUID().uuidString
    let hash = try hasher.make(salt + password).makeString()
    return (hash: hash, salt: salt)
  }
}
