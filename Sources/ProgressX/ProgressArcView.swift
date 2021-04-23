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

struct ProgressArcView: View {

    var configuration: Configuration
    var color: ColorTheme {
        configuration.color
    }

    var body: some View {
        GeometryReader {
            self.trailingArcView(for: $0.size)
            self.separatorView(for: $0.size)
            self.leadingArcView(for: $0.size)
        }
    }

    func leadingArcView(for size: CGSize) -> some View {
        Path {
            $0.addArc(center: self.arcCenter(for: size),
                      radius: size.width,
                      startAngle: Angle(radians: .pi),
                      endAngle: Angle(radians: .pi * 1.5),
                      clockwise: false)
        }
        .strokedPath(StrokeStyle(lineWidth: configuration.strokeWidth, lineCap: .round))
        .foregroundColor(color.foreground)
    }

    func separatorView(for size: CGSize) -> some View {
        Path {
            $0.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + configuration.circleSize * 0.5))
            $0.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2 - configuration.circleSize * 0.5))
        }
        .strokedPath(StrokeStyle(lineWidth: configuration.strokeWidth, lineCap: .round))
        .foregroundColor(color.foreground)
    }

    func trailingArcView(for size: CGSize) -> some View {
        Path {
            $0.addArc(center: self.arcCenter(for: size),
                      radius: size.width,
                      startAngle: Angle(radians: .pi * 1.5),
                      endAngle: Angle(radians: .pi * 2),
                      clockwise: false)
        }
        .stroke(lineWidth: configuration.strokeWidth)
        .foregroundColor(color.foreground)
    }

    func arcCenter(for size: CGSize) -> CGPoint {
        CGPoint(x: size.width / 2, y: size.height / 2 + size.width)
    }
}

#if DEBUG
struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressArcView(configuration: .defaultLight)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .colorScheme(.light)

        ProgressArcView(configuration: .defaultDark)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .colorScheme(.dark)
    }
}
#endif
