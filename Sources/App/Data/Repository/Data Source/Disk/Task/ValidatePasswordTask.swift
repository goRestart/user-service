import Validation

private struct PasswordConstraints {
  static let minimumLenght = 6
  static let maximumLenght = 100 // 🐛 http://bit.ly/2B7MpOC
}

struct ValidatePasswordTask {
  
  func validate(_ password: String) throws {
    do {
      try password.trim().validated(
        by: Count.min(PasswordConstraints.minimumLenght)
        && Count.max(PasswordConstraints.maximumLenght)
      )
    } catch is ValidationError {
      throw UserCreationError.invalidPassword
    }
  }
}
