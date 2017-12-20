import Foundation

struct VerifyUserCredentialsTask {
  
  private let verifyPasswordTask: VerifyPasswordTask
  private let getUserByUsernameTask: GetUserByUsernameTask
  
  init(verifyPasswordTask: VerifyPasswordTask,
       getUserByUsernameTask: GetUserByUsernameTask)
  {
    self.verifyPasswordTask = verifyPasswordTask
    self.getUserByUsernameTask = getUserByUsernameTask
  }
  
  func execute(with credentials: Credentials) throws {
    switch credentials {
    case (let credentials as UserCredentials):
      try verify(with: credentials)
    default:
      fatalError("Credentials \(credentials) can't be handled")
    }
  }
  
  private func verify(with credentials: UserCredentials) throws {
    guard let user = try getUserByUsernameTask.execute(credentials.username),
      let password = try user.password() else {
        throw UserCredentialsError.invalidCredentials
    }
    
    if !user.enabled {
      throw UserCredentialsError.disabledUser
    }
    
    try verifyPasswordTask.execute(
      with: credentials,
      password
    )
  }
}
