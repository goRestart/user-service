import Vapor
import HTTP
import CoreService

struct UserController {
  
  private let createUser: CreateUser
  private let verifyUserCredentials: VerifyUserCredentials
 
  init(createUser: CreateUser,
       verifyUserCredentials: VerifyUserCredentials)
  {
    self.createUser = createUser
    self.verifyUserCredentials = verifyUserCredentials
  }
  
  func create(_ request: Request) throws -> ResponseRepresentable {
    guard let credentials = request.basicCredentials else {
      return Response.missingParameters
    }
    
    do {
      let user = try createUser.execute(with: credentials).map()
      let response = UserResponseViewModel(user: user)
      return try response.makeResponse(status: .created)
    } catch UserCreationError.invalidUsername {
      return Response.invalidUsername
    } catch UserCreationError.invalidPassword {
      return Response.invalidPassword
    } catch UserCreationError.invalidEmail {
      return Response.invalidEmail
    } catch UserCreationError.usernameIsAlreadyRegistered {
      return Response.alreadyRegistered(username: credentials.username)
    } catch UserCreationError.emailIsAlreadyRegistered {
      return Response.alreadyRegistered(email: credentials.email)
    }
  }
  
  func verify(_ request: Request) throws -> ResponseRepresentable {
    guard let credentials = request.userCredentials else {
      return Response.missingParameters
    }
    
    do {
      let user = try verifyUserCredentials.execute(with: credentials)?.map()
      let response = UserResponseViewModel(user: user)
      return try response.makeResponse(status: .ok)
    } catch UserCredentialsError.disabledUser {
      return Response.disabledUser
    } catch UserCredentialsError.invalidCredentials {
      return Response.invalidCredentials
    }
  }
}
