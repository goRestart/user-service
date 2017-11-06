import HTTP

extension Response {
  static let invalidUsername = try! Response.error(
    status: .badRequest,
    message: "Invalid username",
    identifier: "user.error.invalid_username"
  )
}
