import Vapor
import HTTP

struct Parameter {
  static let username = "username"
  static let password = "password"
  static let email = "email"
}

struct UserController {
  
  private let createUser: CreateUser
  private let userViewMapper: UserViewMapper
  
  init(createUser: CreateUser,
       userViewMapper: UserViewMapper)
  {
    self.createUser = createUser
    self.userViewMapper = userViewMapper
  }
  
  func create(_ request: Request) throws -> ResponseRepresentable {
    guard let username = request.data[Parameter.username]?.string,
      let password = request.data[Parameter.password]?.string,
      let email = request.data[Parameter.email]?.string else {
        throw Abort.badRequest
    }
    let basicCredentials = BasicCredentials(
      username: username,
      password: password,
      email: email
    )
    
    do {
      let userViewModel = try userViewMapper.map(
        try createUser.execute(with: basicCredentials)
      ).makeJSON()
      return try Response(status: .created, json: userViewModel)
    } catch UserCreationError.invalidUsername {
      return try Response.error(
        status: .badRequest,
        message: "Invalid username",
        code: 1
      )
    } catch UserCreationError.invalidPassword {
      return try Response.error(
        status: .badRequest,
        message: "Invalid password",
        code: 2
      )
    } catch UserCreationError.invalidEmail {
      return try Response.error(
        status: .badRequest,
        message: "Invalid email",
        code: 3
      )
    } catch UserCreationError.usernameIsAlreadyRegistered {
      return try Response.error(
        status: .conflict,
        message: "Username `\(username)` is already registered",
        code: 4
      )
    } catch UserCreationError.emailIsAlreadyRegistered {
      return try Response.error(
        status: .conflict,
        message: "Email `\(email)` is already registered",
        code: 5
      )
    }
  }
}
