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

    var configuration: Configuration
    var milestone: Milestone

    @State var orderFlipped = false
    var color: ColorTheme { configuration.color }

    var body: some View {
        VStack(spacing: 0) {
            if orderFlipped {
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
            .font(.body)
            .foregroundColor(color.text)
    }

    var dividerView: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(color.foreground)
            .overlay(Rectangle().offset(x: 0, y: -1))
            .frame(width: configuration.dividerWidth, height: configuration.dividerHeight)
    }

    var circleView: some View {
        Circle()
            .strokeBorder(color.foreground, lineWidth: configuration.strokeWidth)
            .background(Circle()
                            .foregroundColor(milestone.hasCompleted ? color.foreground : .clear)
                            .padding(configuration.strokeWidth * 2))
            .background(color.background)
            .clipShape(Circle())
            .frame(width: configuration.circleSize, height: configuration.circleSize)
    }
}

#if DEBUG
struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestonCircleView(configuration: .defaultLight,
                           milestone: Milestone(message: "Hello world",
                                                startDate: Date(),
                                                duration: 10,
                                                hasCompleted: true))
            .background(Color.white)
            .colorScheme(.light)

        MilestonCircleView(configuration: .defaultDark,
                           milestone: Milestone(message: "Hello world",
                                                startDate: Date(),
                                                duration: 10,
                                                hasCompleted: true))
            .background(Color.black)
            .colorScheme(.dark)
    }
}
#endif
