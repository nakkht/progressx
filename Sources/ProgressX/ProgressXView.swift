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
        .onAppear {
            self.viewModel.startTimers()
        }
    }
    
    func milestoneView(for size: CGSize) -> some View {
        ForEach(viewModel.milestones) {
            MilestonCircleView(configuration: configuration, milestone: $0)
                .animation(nil)
                .offset(y: -(size.width - (self.configuration.circleSize / 2 + self.configuration.dividerHeight)))
                .rotationEffect(.radians(viewModel.isInProgress ? -.pi * 0.5 : .pi * 0.5))
                .animation(.linear(duration: $0.duration * 2))
                .position(arcCenter(for: size))
        }
    }
    
    var infoText: some View {
        VStack {
            Spacer()
            Text("\(self.viewModel.currentTime)")
                .font(.system(size: 24))
                .foregroundColor(color.text)
        }
    }
    
    func arcCenter(for size: CGSize) -> CGPoint {
        CGPoint(x: size.width / 2, y: size.height / 2 + size.width)
    }
}

#if DEBUG
struct ProgressXView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProgressXView(viewModel: ProgressXViewModel([Milestone(message: "Startup", startTime: Date(), duration: 5),
                                                     Milestone(message: "Liftoff", startTime: Date(), duration: 10)]),
                      configuration: .defaultLight)
            .background(Color.white)
            .colorScheme(.light)
            .edgesIgnoringSafeArea(.all)
        
        ProgressXView(viewModel: ProgressXViewModel([Milestone(message: "Startup", startTime: Date(), duration: 5),
                                                     Milestone(message: "Liftoff", startTime: Date(), duration: 10)]),
                      configuration: .defaultDark)
            .background(Color.black)
            .colorScheme(.dark)
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
