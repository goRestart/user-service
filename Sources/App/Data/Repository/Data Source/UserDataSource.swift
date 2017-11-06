import Foundation

protocol UserDataSource {
  func create(with credentials: Credentials) throws -> User
  func verify(with credentials: Credentials) throws
}
