import Foundation

struct UserRepository {
  
  private let diskDataSource: UserDataSource
  
  init(diskDataSource: UserDataSource) {
    self.diskDataSource = diskDataSource
  }
  
  func create(with credentials: Credentials) throws -> User {
    return try diskDataSource.create(with: credentials)
  }
}
