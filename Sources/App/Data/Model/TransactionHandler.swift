import FluentProvider

final class TransactionHandler: Model {
  
  let storage = Storage()
  
  init(row: Row) throws {}
  func makeRow() throws -> Row { return Row() }
}

// MARK: - Preparations

extension TransactionHandler: Preparation {
  static func prepare(_ database: Database) throws {}
  static func revert(_ database: Database) throws {}
}
