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

import SwiftUI

struct ProgressXView: View {
    
    var milestones: [Info]
    
    @State private var moveAlongPath = false
    
    var body: some View {
        ZStack {
            ProgressArcView()
            GeometryReader {
                self.milestoneView(for: $0.size)
            }
        }
        .background(Color.blue.opacity(0.3))
        .frame(height: 200)
        .onAppear {
            self.moveAlongPath.toggle()
        }
    }
    
    func milestoneView(for size: CGSize) -> some View {
        ForEach(milestones) {
            MilestonCircleView(message: $0.message)
                .offset(y: -(size.width - 19))
                .rotationEffect(.radians(self.moveAlongPath ? 0.0 : .pi*2))
                .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
                .position(CGPoint(x: size.width/2, y: size.height/2 + size.width))
        }
    }
}

#if DEBUG
struct ProgressXView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressXView(milestones: [Info(message: "Dragon")])
    }
}
#endif
