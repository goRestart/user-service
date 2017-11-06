import FluentProvider

final class PasswordDiskModel: Model {
  
  let storage = Storage()
  
  var hash: String
  var salt: String
  
  init(hash: String, salt: String) {
    self.hash = hash
    self.salt = salt
  }
  
  init(row: Row) throws {
    hash = try row.get(Keys.hash)
    salt = try row.get(Keys.salt)
    id = try row.get(idKey)
  }
  
  func makeRow() throws -> Row {
    var row = Row()
    try row.set(Keys.hash, hash)
    try row.set(Keys.salt, salt)
    try row.set(idKey, id)
    return row
  }
  
  // MARK: - Database keys
  
  struct Keys {
    static let hash = "hash"
    static let salt = "salt"
  }
}

// MARK: - Customizations

extension PasswordDiskModel: Timestampable {
  static let name = "password"
  static let entity = "passwords"
}

// MARK: - Preparations

extension PasswordDiskModel: Preparation {
  static func prepare(_ database: Database) throws {
    try database.create(PasswordDiskModel.self) { builder in
      builder.id()
      builder.string(Keys.hash)
      builder.string(Keys.salt)
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}
