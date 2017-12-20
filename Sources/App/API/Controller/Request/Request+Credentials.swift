import HTTP

private struct Parameter {
  static let username = "username"
  static let password = "password"
  static let email = "email"
}

extension Request {
  var basicCredentials: BasicCredentials? {
    guard let username = data[Parameter.username]?.string,
      let password = data[Parameter.password]?.string,
      let email = data[Parameter.email]?.string else {
        return nil
    }
    return BasicCredentials(
      username: username,
      password: password,
      email: email
    )
  }
  
  var userCredentials: UserCredentials? {
    guard let username = data[Parameter.username]?.string,
      let password = data[Parameter.password]?.string else {
        return nil
    }
    return UserCredentials(
      username: username,
      password: password
    )
  }
}
