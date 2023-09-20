//

import SwiftUI

struct ContentView: View {
    @State var selectedPhotoGroup : PhotoGroup? = nil
    @State var selectedIndex : Int = 0
    @State var showFullScreenImage = false
    
    var photogroups = [
        PhotoGroup(images: ["camping", "camping-1", "camping-2"], name: "Camping", thumbnail: "camping"),
        PhotoGroup(images: ["cycling", "cycling-1", "cycling-2"], name: "Cycling", thumbnail: "cycling-2"),
        PhotoGroup(images: ["food", "food-1", "food-2"], name: "Eating", thumbnail: "food"),
    ]
    
    var drag: some Gesture {
        DragGesture()
            .onEnded { value in
                if value.translation.width > 0 {
                    increaseSelectedIndex()
                    return
                }
                
                if value.translation.width < 0 {
                    decreaseSelectedIndex()
                    return
                }
            }
    }
    
    
    var body: some View {
        VStack {
            Text("My Photo Gallery").font(.title2).padding(.bottom, 10)
                Image(selectedPhotoGroup?.images[selectedIndex] ?? "no-image").resizable().frame(width: 348, height: 412)
                    .cornerRadius(8)
                    .gesture(drag)
                    .onTapGesture {
                        showFullScreenImage = true
                    }
            
            Text("\(selectedPhotoGroup?.name ?? "no-name") Trips").font(.title3).padding(.bottom, 40)
            
            
            HStack {
                Spacer()
                ForEach(photogroups, id:\.name) { p in
                    VStack {
                        Image(p.thumbnail).resizable().frame(width: 50, height: 50)
                            .cornerRadius(8)
                        
                        Text(p.name).font(.body)
                    }.onTapGesture {
                        resetSelectedIndex()
                        selectedPhotoGroup = p
                    }
                    Spacer()
                    
                }
                
            }
        }
        .padding(.leading, 20).padding(.trailing, 20)
        .onAppear() {
            selectedPhotoGroup = photogroups.first
        }.fullScreenCover(isPresented: $showFullScreenImage) {
            ImageView(imageName: selectedPhotoGroup?.images[selectedIndex] ?? "no-image")
        }
    }
    
    func increaseSelectedIndex() {
        if selectedIndex < 2 {
            selectedIndex += 1
            return
        }
        
        selectedIndex = 0
    }
    
    func decreaseSelectedIndex() {
        if selectedIndex >= 1 {
            selectedIndex -= 1
            return
        }
        
        selectedIndex = 2
    }
    
    func resetSelectedIndex() {
        selectedIndex = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
