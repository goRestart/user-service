import Vapor

private struct Endpoint {
  static let create = "/"
  static let verify = "/verify"
}

struct UserRouteCollection: RouteCollection {
  
  private let userController: UserController
  
  init(userController: UserController) {
    self.userController = userController
  }
  
  func build(_ builder: RouteBuilder) throws {
    builder.post(Endpoint.create) { request in
      return try self.userController.create(request)
    }
    builder.get(Endpoint.verify) { request in
      return try self.userController.verify(request)
    }
  }
}
