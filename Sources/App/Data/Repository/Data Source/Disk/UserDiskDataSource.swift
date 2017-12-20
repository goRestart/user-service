import Foundation

struct UserDiskDataSource: UserDataSource {
  
  private let createUserTaskProvider: CreateUserTaskProvider
  private let verifyUserCredentialsTask: VerifyUserCredentialsTask
  private let getUserByUsernameTask: GetUserByUsernameTask
  private let userMapper: UserMapper
  
  init(createUserTaskProvider: CreateUserTaskProvider,
       verifyUserCredentialsTask: VerifyUserCredentialsTask,
       getUserByUsernameTask: GetUserByUsernameTask,
       userMapper: UserMapper)
  {
    self.createUserTaskProvider = createUserTaskProvider
    self.verifyUserCredentialsTask = verifyUserCredentialsTask
    self.getUserByUsernameTask = getUserByUsernameTask
    self.userMapper = userMapper
  }
  
  func create(with credentials: BasicCredentials) throws -> User {
    let user = try createUserTaskProvider.createUserTask.execute(with: credentials)
    return try userMapper.map(user)
  }
  
  func verify(with credentials: Credentials) throws {
    try verifyUserCredentialsTask.execute(with: credentials)
  }
  
  func findBy(username: String) throws -> User? {
    let user = try getUserByUsernameTask.execute(username)
    return try userMapper.map(user)
  }
}
