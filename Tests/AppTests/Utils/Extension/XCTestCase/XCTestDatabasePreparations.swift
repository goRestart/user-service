import XCTest
import Vapor
import FluentProvider
import Testing

class XCTestDatabasePreparations: XCTestCase {
  
  public var database: Database!
  public var droplet: Droplet!
  
  override func setUp() {
    super.setUp()
    Fluent.autoForeignKeys = false
    Testing.onFail = XCTFail
    
    let driver = try! MemoryDriver()
    droplet = try! Droplet.testable()
    database = Database(driver)
    initializeDatabase()
  }
  
  override func tearDown() {
    super.tearDown()
    try! database.revertAll(droplet.config.preparations)
  }
  
  private func initializeDatabase() {
    try! database.prepare(droplet.config.preparations)
  }
}
