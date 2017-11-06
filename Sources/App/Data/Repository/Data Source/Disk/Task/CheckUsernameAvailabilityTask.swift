import Foundation

struct CheckUsernameAvailabilityTask {
  
  func execute(_ username: String) throws {
    if try UserDiskModel
      .makeQuery()
      .filter(UserDiskModel.Keys.username, equals: username)
      .count() > 0 {
      throw UserCreationError.usernameIsAlreadyRegistered
    }
  }
}
