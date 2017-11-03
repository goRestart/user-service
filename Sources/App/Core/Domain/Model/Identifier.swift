import Foundation

struct Identifier<Entity> {
  let value: String
  
  init(_ value: String) throws {
    self.value = value
  }
}
