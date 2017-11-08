import Validation

struct UsernameConstraints {
  static let minimumLenght = 3
  static let maximumLenght = 30
}

struct ValidateUsernameTask {

  func validate(_ username: String) throws {
    do {
      try username.validated(
        by: Count.min(UsernameConstraints.minimumLenght)
          && Count.max(UsernameConstraints.maximumLenght)
      )
      try username.replacingOccurrences(of: "-", with: "")
        .replacingOccurrences(of: "_", with: "")
        .validated(by: OnlyAlphanumeric())
    } catch is ValidationError {
      throw UserCreationError.invalidUsername
    }
  }
}
