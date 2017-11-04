import Foundation

enum UserCreationError: Error {
  case invalidUsername
  case invalidPassword
  case invalidEmail
  case usernameIsAlreadyRegistered
  case emailIsAlreadyRegistered
}
