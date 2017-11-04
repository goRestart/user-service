import Foundation

struct UserMapper {
  
  func map(_ from: UserDiskModel) throws -> User {
    return User(
      identifier: Identifier(from.id!.string!),
      username: from.username,
      email: from.email
    )
  }
}
