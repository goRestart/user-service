import Foundation

extension Assembly {
  var userRouteController: UserRouteCollection {
    return UserRouteCollection(
      userController: userController
    )
  }
  
  private var userController: UserController {
    return UserController(
      createUser: createUser,
      userViewMapper: userViewMapper
    )
  }
}