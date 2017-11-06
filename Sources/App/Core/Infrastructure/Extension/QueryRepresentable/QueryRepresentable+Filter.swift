import Fluent

extension QueryRepresentable where Self: ExecutorRepresentable {
  public func filter(_ field: String, equals to: String) throws -> Query<Self.E> {
    let query = "LOWER(\(field)) = LOWER('\(to)')"
    return try makeQuery().filter(raw: query)
  }
}
