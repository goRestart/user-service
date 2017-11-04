import Foundation

struct ValidateBasicCredentialsTask {
  
  private let validateEmailTask: ValidateEmailTask
  private let validateUsernameTask: ValidateUsernameTask
  private let validatePasswordTask: ValidatePasswordTask
  private let checkUsernameAvailabilityTask: CheckUsernameAvailabilityTask
  private let checkEmailAvailabilityTask: CheckEmailAvailabilityTask

  init(validateEmailTask: ValidateEmailTask,
       validateUsernameTask: ValidateUsernameTask,
       validatePasswordTask: ValidatePasswordTask,
       checkUsernameAvailabilityTask: CheckUsernameAvailabilityTask,
       checkEmailAvailabilityTask: CheckEmailAvailabilityTask)
  {
    self.validateEmailTask = validateEmailTask
    self.validateUsernameTask = validateUsernameTask
    self.validatePasswordTask = validatePasswordTask
    self.checkUsernameAvailabilityTask = checkUsernameAvailabilityTask
    self.checkEmailAvailabilityTask = checkEmailAvailabilityTask
  }
  
  func validate(_ credentials: BasicCredentials) throws {
    try validateUsernameTask.validate(credentials.username)
    try validatePasswordTask.validate(credentials.password)
    try validateEmailTask.validate(credentials.email)
    try checkUsernameAvailabilityTask.execute(credentials.username)
    try checkEmailAvailabilityTask.execute(credentials.email)
  }
}
