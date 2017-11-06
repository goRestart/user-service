import Foundation

extension Assembly {
  var createUser: CreateUser {
    return CreateUser(
      userRepository: userRepository
    )
  }
  
  var verifyUserCredentials: VerifyUserCredentials {
    return VerifyUserCredentials(
      userRepository: userRepository
    )
  }
}
