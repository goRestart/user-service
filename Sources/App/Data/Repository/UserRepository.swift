import Foundation

struct UserRepository {
  
  private let diskDataSource: UserDataSource
  
  init(diskDataSource: UserDataSource) {
    self.diskDataSource = diskDataSource
  }
  
  func create(with credentials: BasicCredentials) throws -> User {
    return try diskDataSource.create(with: credentials)
  }
  
  func verify(with credentials: Credentials) throws {
    return try diskDataSource.verify(with: credentials)
  }
  
  func findBy(username: String) throws -> User? {
    return try diskDataSource.findBy(username: username)
  }
}
