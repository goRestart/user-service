import Foundation

extension Assembly {
  var userRepository: UserRepository {
    return UserRepository(
      diskDataSource: userDiskDataSource
    )
  }
  
  private var userDiskDataSource: UserDiskDataSource {
    return UserDiskDataSource(
      createUserTaskProvider: self,
      userMapper: userMapper
    )
  }
}
