import HTTP

extension Response {
  static let invalidPassword = try! Response.error(
    status: .badRequest,
    message: "Invalid password",
    code: 2
  )
}
