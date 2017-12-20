import Foundation
import CoreService

struct UserMapper: Mappable {
  
  func map(_ from: UserDiskModel) throws -> User {
    return User(
      id: Identifier(from.id!.string!),
      username: from.username,
      email: from.email
    )
  }
}
