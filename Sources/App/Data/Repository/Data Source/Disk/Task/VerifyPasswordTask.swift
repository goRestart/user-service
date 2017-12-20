import Vapor

struct VerifyPasswordTask {
  
  private let createPasswordHashTask: CreatePasswordHashTask
  private let hasher: HashProtocol
  
  init(createPasswordHashTask: CreatePasswordHashTask,
       hasher: HashProtocol)
  {
    self.createPasswordHashTask = createPasswordHashTask
    self.hasher = hasher
  }
  
  func execute(with credentials: UserCredentials, _ password: PasswordDiskModel) throws {
    do {
      let hashedCredentials = createPasswordHashTask.hash(for: password.salt, and: credentials.password)
      let isHashCorrect = try hasher.check(hashedCredentials, matchesHash: password.hash)
      
      guard isHashCorrect else {
        throw UserCredentialsError.invalidCredentials
      }
    } catch {
      throw UserCredentialsError.invalidCredentials
    }
  }
}
