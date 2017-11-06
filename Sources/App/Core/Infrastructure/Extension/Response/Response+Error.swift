import HTTP
import JSON

extension Response {
  static func error(status: Status,
                    message: String,
                    identifier: String) throws -> Response
  {
    var json = JSON()
    try json.set("message", message)
    try json.set("identifier", identifier)
    
    return try Response(
      status: status,
      json: json
    )
  }
}
