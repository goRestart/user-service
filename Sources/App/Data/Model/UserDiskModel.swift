import FluentProvider

final class UserDiskModel: Model {
  
  let storage = Storage()
  
  var username: String
  var email: String
  var passwordId: Fluent.Identifier
  var enabled = true
  
  init(username: String,
       email: String,
       passwordId: Fluent.Identifier)
  {
    self.username = username
    self.email = email
    self.passwordId = passwordId
  }
  
  init(row: Row) throws {
    username = try row.get(Keys.username)
    email = try row.get(Keys.email)
    passwordId = try row.get(Keys.passwordId)
    enabled = try row.get(Keys.enabled)
  }
  
  func makeRow() throws -> Row {
    var row = Row()
    try row.set(Keys.username, username)
    try row.set(Keys.email, email)
    try row.set(Keys.passwordId, passwordId)
    try row.set(Keys.enabled, enabled)
    return row
  }

  // MARK: - Relations
  
  func password() throws -> PasswordDiskModel? {
    return try parent(id: passwordId).get()
  }
  
  // MARK: - Database keys
  
  struct Keys {
    static let username = "username"
    static let email = "email"
    static let passwordId = "password_id"
    static let enabled = "enabled"
  }
}

// MARK: - Customizations

extension UserDiskModel: Timestampable {
  static let name = "user"
  static let entity = "users"
}

// MARK: - Preparations

extension UserDiskModel: Preparation {
  static func prepare(_ database: Database) throws {
    try database.create(self) { builder in
      builder.id()
      builder.string(Keys.username, optional: false, unique: true)
      builder.string(Keys.email, optional: false, unique: true)
      builder.parent(PasswordDiskModel.self, foreignIdKey: Keys.passwordId)
      builder.bool(Keys.enabled, default: true)
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}
