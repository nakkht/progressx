//
// Copyright 2020 Paulius Gudonis, neqsoft
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

import Foundation
import Combine

class ProgressXViewModel: ObservableObject {
    
    @Published var milestones = [Milestone]()
    
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    let formatter = DateFormatter()
    private var timers: [Timer]?
    
    init(_ milestones: [Milestone]) {
        self.timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        self.formatter.dateFormat = "HH:mm:ss"
        self.milestones = milestones
    }
    
    func scheduleUpdates() {
        timers = []
        self.milestones.forEach { (milestone) in
            let timer = Timer.scheduledTimer(withTimeInterval: milestone.duration, repeats: false) { (timer) in
                var milestone = milestone
                milestone.isCompleted = true
                if let index = self.milestones.firstIndex(where: { $0.id == milestone.id }) {
                    self.milestones[index] = milestone
                }
                self.timers?.removeAll(where: { $0 === timer })
            }
            timers?.append(timer)
        }
    }
}
