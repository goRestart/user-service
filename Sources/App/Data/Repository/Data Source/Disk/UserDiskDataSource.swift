import Foundation

struct UserDiskDataSource: UserDataSource {
  
  private let createUserTaskProvider: CreateUserTaskProvider
  private let userMapper: UserMapper
  
  init(createUserTaskProvider: CreateUserTaskProvider,
       userMapper: UserMapper)
  {
    self.createUserTaskProvider = createUserTaskProvider
    self.userMapper = userMapper
  }
  
  func create(with credentials: Credentials) throws -> User {
    return try userMapper.map(
      try createUserTaskProvider.createUserTask.execute(with: credentials)
    )
  }
}
