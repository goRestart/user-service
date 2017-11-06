import Foundation

struct UserDiskDataSource: UserDataSource {
  
  private let createUserTaskProvider: CreateUserTaskProvider
  private let verifyUserCredentialsTask: VerifyUserCredentialsTask
  private let userMapper: UserMapper
  
  init(createUserTaskProvider: CreateUserTaskProvider,
       verifyUserCredentialsTask: VerifyUserCredentialsTask,
       userMapper: UserMapper)
  {
    self.createUserTaskProvider = createUserTaskProvider
    self.verifyUserCredentialsTask = verifyUserCredentialsTask
    self.userMapper = userMapper
  }
  
  func create(with credentials: Credentials) throws -> User {
    return try userMapper.map(
      try createUserTaskProvider.createUserTask.execute(with: credentials)
    )
  }
  
  func verify(with credentials: Credentials) throws {
    try verifyUserCredentialsTask.execute(with: credentials)
  }
}
