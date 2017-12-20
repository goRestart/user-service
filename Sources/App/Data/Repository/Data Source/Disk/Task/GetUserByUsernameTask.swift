import CoreService

struct GetUserByUsernameTask {
  func execute(_ username: String) throws -> UserDiskModel? {
    return try UserDiskModel.makeQuery()
      .filter(UserDiskModel.Keys.username, equals: username)
      .first()
  }
}
