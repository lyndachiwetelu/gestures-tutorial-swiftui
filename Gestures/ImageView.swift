//

import SwiftUI

struct ImageView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var scale = 1.0
    @State private var angle = Angle(degrees: 0.0)
    
    var imageName: String
    
    var drag: some Gesture {
        DragGesture()
            .onEnded { value in
                if value.translation.height > 0 {
                    dismiss()
                    return
                }
            }
    }
    
    var doubleTap: some Gesture {
        TapGesture(count: 2)
            .onEnded {
            resetEffect()
        }
    }
    
    var zoom: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                if value != 0.0  {
                    scale = value.magnitude
                }
               
            }
    }
    
    var rotate: some Gesture {
        RotationGesture()
            .onChanged { rotationAngle in
                angle = rotationAngle
            }
    }
    
    var zoomAndRotate: some Gesture {
        MagnificationGesture()
            .simultaneously(with: RotationGesture())
            .onChanged { value in
                let valueToScaleBy = value.first?.magnitude ?? 1.0
                if valueToScaleBy != 0.0  {
                    scale = valueToScaleBy
                }
                
                angle = value.second ?? Angle(degrees: 0.0)
            }
    }
    
    var body: some View {
        ZStack {
            Image(imageName).resizable().frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * (2 / 3) )
                .aspectRatio(contentMode: .fit)
                .gesture(drag)
                .gesture(doubleTap)
                .rotationEffect(angle, anchor: .center)
                .scaleEffect(scale, anchor: .center)
                .gesture(zoomAndRotate)
        }.edgesIgnoringSafeArea(.all)
        
    }
    
    func resetEffect() -> Void {
        scale = 1.0
        angle = Angle(degrees: 0.0)
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageName: "cycling-1")
    }
}
