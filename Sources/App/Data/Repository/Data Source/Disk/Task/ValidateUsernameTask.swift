import Validation

private struct UsernameConstraints {
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
      try cleanUp(username)
        .validated(by: OnlyAlphanumeric())
    } catch is ValidationError {
      throw UserCreationError.invalidUsername
    }
  }
  
  private func cleanUp(_ username: String) -> String {
    return username
      .replacingOccurrences(of: "-", with: "")
      .replacingOccurrences(of: "_", with: "")
  }
}
