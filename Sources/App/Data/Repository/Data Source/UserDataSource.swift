import Foundation

protocol UserDataSource {
  func create(with credentials: BasicCredentials) throws -> User
  func verify(with credentials: Credentials) throws
  func findBy(username: String) throws -> User?
}
