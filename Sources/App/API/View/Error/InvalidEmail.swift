import HTTP

extension Response {
  static let invalidEmail = try! Response.error(
    status: .badRequest,
    message: "Invalid email",
    identifier: "user.error.invalid_email"
  )
}
