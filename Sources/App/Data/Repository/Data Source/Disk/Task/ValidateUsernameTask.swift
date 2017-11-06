import Validation

struct ValidateUsernameTask {

  func validate(_ username: String) throws {
    do {
      try username.validated(
        by: Count.min(3) && Count.max(30)
      )
      try username.replacingOccurrences(of: "-", with: "")
        .replacingOccurrences(of: "_", with: "")
        .validated(by: OnlyAlphanumeric())
    } catch is ValidationError {
      throw UserCreationError.invalidUsername
    }
  }
}
