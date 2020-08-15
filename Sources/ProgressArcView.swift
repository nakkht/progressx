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

struct ProgressArcView: View {
    
    var strokeWidth: CGFloat = 3
    var leadingColor = Color.primary
    var trailingColor = Color.gray
    var dividerHeight: CGFloat = 14
    
    var body: some View {
        GeometryReader {
            self.trailingArcView(for: $0.size)
            self.leadingArcView(for: $0.size)
        }
    }
    
    func leadingArcView(for size: CGSize) -> some View {
        Path {
            $0.addArc(center: CGPoint(x: size.width/2, y: size.height/2 + size.width),
                      radius: size.width,
                      startAngle: Angle(radians: .pi),
                      endAngle: Angle(radians: .pi*1.5),
                      clockwise: false)
            $0.move(to: CGPoint(x: size.width/2, y: size.height/2 + dividerHeight*0.5))
            $0.addLine(to: CGPoint(x: size.width/2, y: size.height/2 - dividerHeight*0.5))
            
        }
        .strokedPath(StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
        .foregroundColor(leadingColor)
    }
    
    func trailingArcView(for size: CGSize) -> some View {
        Path {
            $0.addArc(center: CGPoint(x: size.width/2, y: size.height/2 + size.width),
                      radius: size.width,
                      startAngle: Angle(radians: .pi*1.5),
                      endAngle: Angle(radians: .pi*2),
                      clockwise: false)
        }
        .stroke(lineWidth: strokeWidth)
        .foregroundColor(trailingColor)
    }
}

#if DEBUG
struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressArcView()
    }
}
#endif
