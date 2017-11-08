import Foundation
import CoreService
import Fluent
import Vapor

protocol CreateUserTaskProvider {
  var createUserTask: CreateUserTask { get }
}

struct CreateUserTask {
  
  private let validateBasicCredentialsTask: ValidateBasicCredentialsTask
  private let createPasswordHashTask: CreatePasswordHashTask

  init(validateBasicCredentialsTask: ValidateBasicCredentialsTask,
       createPasswordHashTask: CreatePasswordHashTask)
  {
    self.validateBasicCredentialsTask = validateBasicCredentialsTask
    self.createPasswordHashTask = createPasswordHashTask
  }
  
  func execute(with credentials: Credentials) throws -> UserDiskModel {
    switch credentials {
    case (let credentials as BasicCredentials):
      return try create(with: credentials)
    default:
      fatalError("Credentials \(credentials) can't be handled")
    }
  }
  
  private func create(with basicCredentials: BasicCredentials) throws -> UserDiskModel {
    try validateBasicCredentialsTask.validate(basicCredentials)
    let ciphered = try createPasswordHashTask.create(
      with: basicCredentials.password
    )
    
    return try TransactionHandler.database!.transaction { connection in
      let password = PasswordDiskModel(
        hash: ciphered.hash,
        salt: ciphered.salt
      )
      
      try password.makeQuery(connection).save()

      let user = try UserDiskModel(
        username: basicCredentials.username,
        email: basicCredentials.email,
        passwordId: password.assertExists()
      )
      
      try user.makeQuery(connection).save()
      return user
    }
  }
}
