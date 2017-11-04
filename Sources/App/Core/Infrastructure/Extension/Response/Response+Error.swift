import HTTP
import JSON

extension Response {
  static func error(status: Status,
                    message: String,
                    code: Int) throws -> Response
  {
    var json = JSON()
    try json.set("message", message)
    try json.set("code", code)
    
    return try Response(
      status: status,
      json: json
    )
  }
}
