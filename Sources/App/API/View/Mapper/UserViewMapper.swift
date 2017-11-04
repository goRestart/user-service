import Foundation

struct UserViewMapper {
  
  func map(_ from: User) throws -> UserViewModel {
    return UserViewModel(
      identifier: from.identifier.value,
      username: from.username,
      email: from.email
    )
  }
}
