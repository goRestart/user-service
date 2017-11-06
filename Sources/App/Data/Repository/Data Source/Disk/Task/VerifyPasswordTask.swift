import Vapor

struct VerifyPasswordTask {
  
  private let createPasswordHashTask: CreatePasswordHashTask
  
  init(createPasswordHashTask: CreatePasswordHashTask) {
    self.createPasswordHashTask = createPasswordHashTask
  }
  
  func execute(with credentials: UserCredentials, _ password: PasswordDiskModel) throws {
    do {
      let hashedCredentials = try createPasswordHashTask.create(
        with: credentials.password,
        salt: password.salt
      )
      
      let isHashCorrect = hashedCredentials.hash == password.hash
      if !isHashCorrect {
        throw UserCredentialsError.invalidCredentials
      }
    } catch {
      throw UserCredentialsError.invalidCredentials
    }
  }
}
