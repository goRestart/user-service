import HTTP

extension Response {
  static let invalidCredentials = try! Response.error(
    status: .unauthorized,
    message: "Invalid credentials",
    identifier: "user.error.invalid_credentials"
  )
}
