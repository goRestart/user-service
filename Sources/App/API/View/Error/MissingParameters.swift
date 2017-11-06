import HTTP

extension Response {
  static let missingParameters = try! Response.error(
    status: .badRequest,
    message: "Missing parameters",
    identifier: "user.error.missing_parameters"
  )
}

