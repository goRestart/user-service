import CoreService
import Fluent
import PostgreSQL
import Validation

// MARK: - CreateUserTaskProvider

extension Assembly: CreateUserTaskProvider {
  var createUserTask: CreateUserTask {
    return CreateUserTask(
      validateBasicCredentialsTask: validateBasicCredentialsTask,
      createPasswordHashTask: createPasswordHashTask
    )
  }
}

extension Assembly {
  
  private var createPasswordHashTask: CreatePasswordHashTask {
    return CreatePasswordHashTask(
      hasher: hasher
    )
  }
  
  private var validateBasicCredentialsTask: ValidateBasicCredentialsTask {
    return ValidateBasicCredentialsTask(
      validateEmailTask: validateEmailTask,
      validateUsernameTask: validateUsernameTask,
      validatePasswordTask: validatePasswordTask,
      checkUsernameAvailabilityTask: checkUsernameAvailabilityTask,
      checkEmailAvailabilityTask: checkEmailAvailabilityTask
    )
  }
  
  private var emailValidator: EmailValidator {
    return EmailValidator()
  }
  
  private var validateEmailTask: ValidateEmailTask {
    return ValidateEmailTask(
      emailValidator: emailValidator
    )
  }

  private var validateUsernameTask: ValidateUsernameTask {
    return ValidateUsernameTask()
  }

  private var validatePasswordTask: ValidatePasswordTask {
    return ValidatePasswordTask()
  }
  
  private var checkUsernameAvailabilityTask: CheckUsernameAvailabilityTask {
    return CheckUsernameAvailabilityTask()
  }
  
  private var checkEmailAvailabilityTask: CheckEmailAvailabilityTask {
    return CheckEmailAvailabilityTask()
  }
}

// MARK: - Verify user credentials

extension Assembly {
  
  var verifyUserCredentialsTask: VerifyUserCredentialsTask {
    return VerifyUserCredentialsTask(
      verifyPasswordTask: verifyPasswordTask
    )
  }
  
  private var verifyPasswordTask: VerifyPasswordTask {
    return VerifyPasswordTask(
      createPasswordHashTask: createPasswordHashTask
    )
  }
}
