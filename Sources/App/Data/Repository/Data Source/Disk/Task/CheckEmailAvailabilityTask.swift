import Foundation

struct CheckEmailAvailabilityTask {
  
  func execute(_ email: String) throws {
    if try UserDiskModel
      .makeQuery()
      .filter(UserDiskModel.Keys.email, equals: email)
      .count() > 0 {
      throw UserCreationError.emailIsAlreadyRegistered
    }
  }
}

