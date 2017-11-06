import HTTP
import XCTest

extension Response {
  @discardableResult
  public func assertResponse(`is` response: Response) throws -> Response {
    XCTAssertEqual(self.status, response.status)
    XCTAssertEqual(self.json, response.json)
    return self
  }
}
