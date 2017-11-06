import Foundation

extension Assembly {
  var createUser: CreateUser {
    return CreateUser(
      userRepository: userRepository
    )
  }
}
