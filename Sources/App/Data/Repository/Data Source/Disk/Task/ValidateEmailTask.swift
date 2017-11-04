import Validation

struct ValidateEmailTask {

  private let emailValidator: EmailValidator
  
  init(emailValidator: EmailValidator) {
    self.emailValidator = emailValidator
  }
  
  func validate(_ email: String) throws {
    do {
      try emailValidator.validate(email)
    } catch is ValidationError {
      throw UserCreationError.invalidEmail
    }
  }
}
