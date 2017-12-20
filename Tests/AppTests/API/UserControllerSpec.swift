import XCTest
import Testing
import HTTP
import CoreTesting
@testable import App
import CoreService

class UserControllerSpec: XCTestDatabasePreparations {
  
  override func setUp() {
    droplet = TestableDroplet.droplet
    super.setUp()
  }
  
  // MARK: - Create user
  
  func test_should_return_bad_request_if_required_parameters_are_not_passed() throws {
    let request = Request(
      method: .post,
      uri: "/"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .missingParameters)
  }
  
  func test_should_return_bad_request_if_username_length_is_lower_than_3() throws {
    let request = Request(
      method: .post,
      uri: "/?username=no&password=12345678&email=test@test.com"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .invalidUsername)
  }

  func test_should_return_bad_request_if_username_length_is_bigger_than_30() throws {
    let request = Request(
      method: .post,
      uri: "/?username=1234567890123456789012345678901&password=12345678&email=test@test.com"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .invalidUsername)
  }

  func test_should_return_bad_request_if_password_length_is_bigger_than_100() throws {
    let password = String(repeating: "*", count: 101)
    let request = Request(
      method: .post,
      uri: "/?username=username&password=\(password)&email=test@test.com"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .invalidPassword)
  }
  
  func test_should_return_bad_request_if_username_has_invalid_characters() throws {
    let request = Request(
      method: .post,
      uri: "/?username=uno_$&password=12345678&email=test@test.com"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .invalidUsername)
  }
  
  func test_should_return_bad_request_if_password_length_is_lower_than_6() throws {
    let request = Request(
      method: .post,
      uri: "/?username=username&password=12345&email=test@test.com"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .invalidPassword)
  }
  
  func test_should_return_bad_request_if_email_is_invalid() throws {
    let request = Request(
      method: .post,
      uri: "/?username=username&password=123456&email=test@testcom"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .invalidEmail)
  }
  
  func test_should_return_conflict_if_username_is_already_registered() throws {
    let username = "skyweb07"
    givenUser(
      username: username
    )
    
    let request = Request(
      method: .post,
      uri: "/?username=\(username)&password=123456&email=test@test.com"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .alreadyRegistered(username: username))
  }
  
  func test_should_return_conflict_if_email_is_already_registered() throws {
    let email = "test@retro.com"
    givenUser(
      email: email
    )
    
    let request = Request(
      method: .post,
      uri: "/?username=username123&password=123456&email=\(email)"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .alreadyRegistered(email: email))
  }
  
  func test_should_return_created_if_user_was_registered_correctly() throws {
    let request = Request(
      method: .post,
      uri: "/?username=username&password=123456&email=test@test.com"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertStatus(is: .created)
  }
  
  // MARK: - Verify credentials
  
  func test_should_return_missing_parameters_if_credentials_are_not_passed() throws {
    let request = Request(
      method: .post,
      uri: "/verify"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .missingParameters)
  }
  
  func test_should_return_unauthorized_if_credentials_are_invalid() throws {
    let request = Request(
      method: .post,
      uri: "/verify?username=fakeUser&password=superpassword"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .invalidCredentials)
  }
  
  func test_should_return_unauthorized_if_user_is_disabled() throws {
    let disabledUsername = "skyweb07"
    givenDisabledUser(
      username: disabledUsername
    )
    
    let request = Request(
      method: .post,
      uri: "/verify?username=\(disabledUsername)&password=superpassword"
    )
    
    try droplet?
      .testResponse(to: request)
      .assertResponse(is: .disabledUser)
  }
}

// MARK: - Manifest

extension UserControllerSpec {
  static let allTests = [
    ("test_should_return_bad_request_if_required_parameters_are_not_passed", test_should_return_bad_request_if_required_parameters_are_not_passed),
    ("test_should_return_bad_request_if_username_length_is_lower_than_3", test_should_return_bad_request_if_username_length_is_lower_than_3),
    ("test_should_return_bad_request_if_username_length_is_bigger_than_30", test_should_return_bad_request_if_username_length_is_bigger_than_30),
    ("test_should_return_bad_request_if_password_length_is_bigger_than_100", test_should_return_bad_request_if_password_length_is_bigger_than_100),
    ("test_should_return_bad_request_if_username_has_invalid_characters", test_should_return_bad_request_if_username_has_invalid_characters),
    ("test_should_return_bad_request_if_password_length_is_lower_than_6", test_should_return_bad_request_if_password_length_is_lower_than_6),
    ("test_should_return_bad_request_if_email_is_invalid", test_should_return_bad_request_if_email_is_invalid),
    ("test_should_return_conflict_if_username_is_already_registered", test_should_return_conflict_if_username_is_already_registered),
    ("test_should_return_conflict_if_email_is_already_registered", test_should_return_conflict_if_email_is_already_registered),
    ("test_should_return_created_if_user_was_registered_correctly", test_should_return_created_if_user_was_registered_correctly),
    ("test_should_return_missing_parameters_if_credentials_are_not_passed", test_should_return_missing_parameters_if_credentials_are_not_passed),
    ("test_should_return_unauthorized_if_credentials_are_invalid", test_should_return_unauthorized_if_credentials_are_invalid),
    ("test_should_return_unauthorized_if_user_is_disabled", test_should_return_unauthorized_if_user_is_disabled)
  ]
}
