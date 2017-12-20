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
  
  func execute(with credentials: BasicCredentials) throws -> UserDiskModel {
    try validateBasicCredentialsTask.validate(credentials)
    let ciphered = try createPasswordHashTask.create(
      with: credentials.password
    )
    
    return try TransactionHandler.database!.transaction { connection in
      let password = PasswordDiskModel(
        hash: ciphered.hash,
        salt: ciphered.salt
      )
      
      try password.makeQuery(connection).save()
      
      let user = try UserDiskModel(
        username: credentials.username,
        email: credentials.email,
        passwordId: password.assertExists()
      )
      
      try user.makeQuery(connection).save()
      return user
    }
  }
}
