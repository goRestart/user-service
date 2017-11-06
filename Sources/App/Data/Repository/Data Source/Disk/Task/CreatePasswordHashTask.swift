import Foundation
import Vapor

struct CreatePasswordHashTask {

  private let hasher: HashProtocol
  
  init(hasher: HashProtocol) {
    self.hasher = hasher
  }
  
  func create(with password: String, salt: String = UUID().uuidString) throws -> (hash: String, salt: String) {
    let hash = try hasher.make(salt + password).makeString()
    return (hash: hash, salt: salt)
  }
}
