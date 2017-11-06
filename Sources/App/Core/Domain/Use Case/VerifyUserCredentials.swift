import Foundation

struct VerifyUserCredentials {
  
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(with credentials: Credentials) throws {
    try userRepository.verify(with: credentials)
  }
}
