import Foundation

struct CreateUser {
  
  private let userRepository: UserRepository
  
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  @discardableResult
  func execute(with credentials: BasicCredentials) throws -> User {
    return try userRepository.create(with: credentials)
  }
}
