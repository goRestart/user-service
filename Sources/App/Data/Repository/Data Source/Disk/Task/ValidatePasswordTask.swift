import Validation

private let minimumPasswordLenght = 6

struct ValidatePasswordTask {
  
  func validate(_ password: String) throws {
    do {
      try password.trim().validated(by: Count.min(minimumPasswordLenght))
    } catch is ValidationError {
      throw UserCreationError.invalidPassword
    }
  }
}
