import HTTP

extension Response {
  static func alreadyRegistered(username: String) -> Response {
    return try! Response.error(
      status: .conflict,
      message: "Username `\(username)` is already registered",
      identifier: "user.error.username.alredy_registered"
    )
  }
  
  static func alreadyRegistered(email: String) -> Response {
    return try! Response.error(
      status: .conflict,
      message: "Email `\(email)` is already registered",
      identifier: "user.error.email.already_registered"
    )
  }
}
