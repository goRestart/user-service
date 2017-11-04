import Foundation

struct CreateUser {
  
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  func execute(with credentials: Credentials) throws -> User {
    return try userRepository.create(with: credentials)
  }
}
