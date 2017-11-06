import Foundation

struct VerifyUserCredentialsTask {
  
  private let verifyPasswordTask: VerifyPasswordTask
  
  init(verifyPasswordTask: VerifyPasswordTask) {
    self.verifyPasswordTask = verifyPasswordTask
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
    guard let user = try UserDiskModel
      .makeQuery()
      .filter(UserDiskModel.Keys.username, equals: credentials.username)
      .first(),
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
