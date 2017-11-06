import HTTP

extension Response {
  static let disabledUser = try! Response.error(
    status: .unauthorized,
    message: "Disabled user",
    identifier: "user.error.disabled_user"
  )
}
