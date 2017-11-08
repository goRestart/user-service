import CoreService

extension Assembly {
  var userMapper: UserMapper {
    return UserMapper()
  }
  
  var userViewMapper: UserViewMapper {
    return UserViewMapper()
  }
}
