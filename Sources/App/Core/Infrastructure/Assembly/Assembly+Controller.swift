import CoreService

extension Assembly {
  var userRouteController: UserRouteCollection {
    return UserRouteCollection(
      userController: userController
    )
  }
  
  private var userController: UserController {
    return UserController(
      createUser: createUser,
      verifyUserCredentials: verifyUserCredentials,
      userViewMapper: userViewMapper
    )
  }
}
