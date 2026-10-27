import XCTest
@testable import MADATA

final class MADATATests:XCTestCase {
    func testMockServersExist(){ XCTAssertFalse(MockData.servers.isEmpty) }
    func testPrioritiesContainCritical(){ XCTAssertTrue(TicketPriority.allCases.contains(.critica)) }
    func testBaseURLUsesHTTPForLocalAcademicServer(){ XCTAssertEqual(AppConfig.apiBaseURL.scheme,"http") }
}
