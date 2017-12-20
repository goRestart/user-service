import Foundation

extension User {
  func map() -> UserViewModel {
    return UserViewModel(
      id: id.value,
      username: username
    )
  }
}
