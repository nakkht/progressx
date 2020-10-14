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

struct MilestonCircleView: View {
    
    var size: CGFloat = 15
    var color: Color = Color(red: 199, green: 200, blue: 200)
    var backgroundColor: Color = Color.black
    var strokeWidth: CGFloat = 2
    var strokeDistance: CGFloat = 4
    var dividerWidth: CGFloat = 3
    var dividerHeight: CGFloat = 5
    var messagePadding: CGFloat = 2
    var orderFlipped = false
    var milestone: Milestone
    
    @Environment(\.colorScheme) private var colorScheme
    
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
        Text(milestone.message.uppercased())
            .font(.footnote)
            .foregroundColor(colorScheme == .light ? color : color.colorInvert() as! Color)
            .padding(messagePadding)
    }
    
    var dividerView: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(color)
            .frame(width: dividerWidth, height: dividerHeight)
    }
    
    var circleView: some View {
        Circle()
            .foregroundColor(milestone.isCompleted ? .white : .none)
            .padding(strokeDistance)
            .background(
                Circle()
                    .strokeBorder(lineWidth: strokeWidth)
                    .foregroundColor(color)
                    .background(backgroundColor))
            .mask(Circle())
            .frame(width: self.size, height: self.size)
    }
}

#if DEBUG
struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestonCircleView(milestone: Milestone(message: "Hello world",
                                                startTime: Date(),
                                                duration: 10))
    }
}
#endif