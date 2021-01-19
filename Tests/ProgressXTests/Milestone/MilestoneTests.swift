//
// Copyright 2021 Paulius Gudonis
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//  

import XCTest
@testable import ProgressX

final class MilestoneTests: XCTestCase {
    
    func testDefaultValues() {
        let id = UUID()
        let message = "messageText"
        let startTime = Date()
        let duration = 10.0
        let milestone = Milestone(id: id, message: message, startTime: startTime, duration: duration)
        let endTime = startTime.addingTimeInterval(duration).timeIntervalSince1970
        
        XCTAssertEqual(id, milestone.id)
        XCTAssertEqual(message, milestone.message)
        XCTAssertEqual(startTime, milestone.startTime)
        XCTAssertEqual(duration, milestone.duration)
        XCTAssertFalse(milestone.isCompleted)
        XCTAssertEqual(endTime, milestone.deadlineTime)
    }
}
