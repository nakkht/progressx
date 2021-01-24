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

import SwiftUI

struct ProgressXView: View {
    
    @ObservedObject var viewModel: ProgressXViewModel
    @State var configuration: Configuration
    
    @State private var moveAlongPath = false
    @State private var currentTime: String = ""
    
    private var color: ColorTheme {
        configuration.color
    }
    
    var body: some View {
        ZStack {
            ProgressArcView(configuration: configuration)
            GeometryReader {
                self.milestoneView(for: $0.size)
            }
            self.infoText
        }
        .frame(height: 200)
        .onAppear {
            self.viewModel.scheduleUpdates()
            self.moveAlongPath.toggle()
        }
    }
    
    func milestoneView(for size: CGSize) -> some View {
        ForEach(viewModel.milestones) {
            MilestonCircleView(configuration: configuration, milestone: $0)
                .animation(nil)
                .offset(y: -(size.width - 12))
                .rotationEffect(.radians(self.moveAlongPath ? -.pi * 0.5 : .pi * 0.5))
                .animation(.linear(duration: $0.duration * 2))
                .position(CGPoint(x: size.width / 2, y: size.height / 2 + size.width))
        }
    }
    
    var infoText: some View {
        VStack {
            Spacer()
            Text("\(currentTime)").onReceive(viewModel.timer) {
                self.currentTime = self.viewModel.formatter.string(from: $0)
            }
            .font(.system(size: 24))
            .foregroundColor(Color(red: 199, green: 200, blue: 200))
        }
    }
}

#if DEBUG
struct ProgressXView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressXView(viewModel: ProgressXViewModel([Milestone(message: "Startup", startTime: Date(), duration: 3),
                                                     Milestone(message: "Liftoff", startTime: Date(), duration: 5)]),
                      configuration: .defaultDark)
    }
}
#endif
