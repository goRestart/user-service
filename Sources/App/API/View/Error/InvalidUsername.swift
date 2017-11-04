import HTTP

extension Response {
  static let invalidUsername = try! Response.error(
    status: .badRequest,
    message: "Invalid username",
    code: 1
  )
}
