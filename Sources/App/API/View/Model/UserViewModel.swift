import HTTP
import JSON

struct UserViewModel {
  let identifier: String
  let username: String
  let email: String
}

// MARK: - NodeRepresentable

extension UserViewModel: JSONRepresentable {
  func makeJSON() throws -> JSON {
    var json = JSON()
    try json.set("id", identifier)
    try json.set("username", username)
    try json.set("email", email)
    return json
  }
}
