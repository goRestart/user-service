import Vapor
import Fluent

extension Assembly {
  public var application: Droplet {
    let droplet =  try! Droplet(config)
    try! droplet.collection(userRouteController)
    return droplet
  }
  
  public var config: Config {
    let config = try! Config()
    try! config.setup()
    return config
  }
  
  var hasher: HashProtocol {
    return CryptoHasher(
      hash: .sha256,
      encoding: .hex
    )
  }
}
