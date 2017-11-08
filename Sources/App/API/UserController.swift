import Vapor
import HTTP
import CoreService

struct Parameter {
  static let username = "username"
  static let password = "password"
  static let email = "email"
}

struct UserController {
  
  private let createUser: CreateUser
  private let verifyUserCredentials: VerifyUserCredentials
  private let userViewMapper: UserViewMapper
  
  init(createUser: CreateUser,
       verifyUserCredentials: VerifyUserCredentials,
       userViewMapper: UserViewMapper)
  {
    self.createUser = createUser
    self.verifyUserCredentials = verifyUserCredentials
    self.userViewMapper = userViewMapper
  }
  
  func create(_ request: Request) throws -> ResponseRepresentable {
    guard let username = request.data[Parameter.username]?.string,
      let password = request.data[Parameter.password]?.string,
      let email = request.data[Parameter.email]?.string else {
        return Response.missingParameters
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
      return Response.invalidUsername
    } catch UserCreationError.invalidPassword {
      return Response.invalidPassword
    } catch UserCreationError.invalidEmail {
      return Response.invalidEmail
    } catch UserCreationError.usernameIsAlreadyRegistered {
      return Response.alreadyRegistered(username: username)
    } catch UserCreationError.emailIsAlreadyRegistered {
      return Response.alreadyRegistered(email: email)
    }
  }
  
  func verify(_ request: Request) throws -> ResponseRepresentable {
    guard let username = request.data[Parameter.username]?.string,
      let password = request.data[Parameter.password]?.string else {
        return Response.missingParameters
    }
    let userCredentials = UserCredentials(
      username: username,
      password: password
    )
    
    do {
      try verifyUserCredentials.execute(with: userCredentials)
      return Response(status: .ok)
    } catch UserCredentialsError.disabledUser {
      return Response.disabledUser
    } catch UserCredentialsError.invalidCredentials {
      return Response.invalidCredentials
    }
  }
}
