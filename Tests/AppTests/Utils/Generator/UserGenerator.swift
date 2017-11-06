import Fluent
@testable import App

func givenUser(username: String = "username",
               password: String = "123456",
               email: String = "test@test.com")
{
  let createUser = resolver.createUser
  let credentials = BasicCredentials(
    username: username,
    password: password,
    email: email
  )
  try! createUser.execute(with: credentials)
}
