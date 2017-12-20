import CoreService

extension Assembly {
  var userRepository: UserRepository {
    return UserRepository(
      diskDataSource: userDiskDataSource
    )
  }
  
  private var userDiskDataSource: UserDiskDataSource {
    return UserDiskDataSource(
      createUserTaskProvider: self,
      verifyUserCredentialsTask: verifyUserCredentialsTask,
      getUserByUsernameTask: getUserByUsernameTask,
      userMapper: userMapper
    )
  }
}
