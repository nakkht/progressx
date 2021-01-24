//
// Copyright 2020 Paulius Gudonis
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
    
    @Published var milestones: [Milestone]
    @Published var currentTime = ""
    @Published var isInProgress = false
    
    private lazy var timers = [Timer]()
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    private var timerCancellable: AnyCancellable?
    
    init(_ milestones: [Milestone]) {
        self.timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        self.milestones = milestones
        self.timerCancellable = self.timer.sink { self.currentTime = self.formatter.string(from: $0) }
    }
    
    func startTimers() {
        milestones.forEach { (milestone) in
            let timer = Timer(fire: milestone.deadline, interval: 0, repeats: false) { (timer) in
                var milestone = milestone
                milestone.hasCompleted = true
                if let index = self.milestones.firstIndex(where: { $0.id == milestone.id }) {
                    self.milestones[index] = milestone
                }
                self.timers.removeAll(where: { $0 === timer })
            }
            RunLoop.main.add(timer, forMode: .common)
            self.timers.append(timer)
        }
        self.isInProgress.toggle()
    }
}
