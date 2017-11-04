import HTTP

extension Response {
  static func alreadyRegistered(username: String) -> Response {
    return try! Response.error(
      status: .conflict,
      message: "Username `\(username)` is already registered",
      code: 4
    )
  }
  
  static func alreadyRegistered(email: String) -> Response {
    return try! Response.error(
      status: .conflict,
      message: "Email `\(email)` is already registered",
      code: 5
    )
  }
}
