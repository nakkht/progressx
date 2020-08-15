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

struct MilestonCircleView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var size: CGFloat = 30
    var color: Color = Color.gray
    var strokeWidth: CGFloat = 2
    var strokeDistance: CGFloat = 5
    var dividerWidth: CGFloat = 3
    var dividerHeight: CGFloat = 20
    var padding: CGFloat = 4
    var message: String
    var orderFlipped = false
    
    var body: some View {
        VStack(spacing: 0) {
            if (orderFlipped) {
                self.messageView
                self.dividerView
                self.circleView
            } else {
                self.circleView
                self.dividerView
                self.messageView
            }
        }
    }
    
    var messageView: some View {
        Text(message)
            .font(.body)
            .foregroundColor(.black)
            .padding(padding)
    }
    
    var dividerView: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(color)
            .frame(width: dividerWidth, height: dividerHeight)
    }
    
    var circleView: some View {
        Circle()
            .foregroundColor(color)
            .padding(strokeDistance)
            .background(
                Circle()
                    .stroke(lineWidth: strokeWidth)
                    .fill(color))
            .frame(width: self.size, height: self.size)
    }
}

#if DEBUG
struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestonCircleView(message: "Hello world").environment(\.colorScheme, .dark)
    }
}
#endif
