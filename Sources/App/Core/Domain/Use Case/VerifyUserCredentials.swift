import Foundation

struct VerifyUserCredentials {
  
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  @discardableResult
  func execute(with credentials: UserCredentials) throws -> User? {
    try userRepository.verify(with: credentials)
    return try userRepository.findBy(username: credentials.username)
  }
}
