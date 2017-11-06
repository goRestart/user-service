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

func givenDisabledUser(username: String = "username",
                       password: String = "123456",
                       email: String = "test@test.com")
{
  givenUser(username: username, password: password, email: email)
  
  let user = try! UserDiskModel
    .makeQuery()
    .filter(UserDiskModel.Keys.username, username)
    .first()
  
  user?.enabled = false
  try! user?.save()
}
