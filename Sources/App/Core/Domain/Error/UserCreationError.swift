import Foundation

enum UserCreationError: Error {
  case invalidUsername
  case invalidPassword
  case invalidEmail
  case usernameAIslreadyRegistered
  case emailIsAlreadyRegistered
}
