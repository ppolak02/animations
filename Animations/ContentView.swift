//
//  ContentView.swift
//  Animations
//
//  Created by Pavol Polak on 19/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    enum Sizes {
        static let pulledOffset: CGFloat = 140
        static let notPulledOffset: CGFloat = 115
    }
  
    @State private var gestureOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var isPulled: Bool = false
    @State private var position: CGPoint = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                VStack(alignment: .center) {
                    Circle()
                        .fill(.green.shadow(.drop(color: .black.opacity(0.2), radius: 5)))
                        .frame(width: 250)
                        .position(.init(x: geometry.size.width * 0.5, y: 200))
                    Spacer()
                    Circle()
                        .fill(.yellow.shadow(.drop(color: .black.opacity(0.2), radius: 5)))
                        .frame(width: 70)
//                        .scaleEffect(scale)
                        .position(position)
                        .opacity(0.5)
                        .gesture(gestureHandler(0, { _ in }))
                }
            }
            .onAppear {
                position = .init(x: geometry.size.width * 0.5, y: 100)
            }
        }
    }
    
    private func gestureHandler(
        _ index: Int,
        _ dragHandler: ((Int) -> Void)?
    ) ->  some Gesture {
       return DragGesture(
            minimumDistance: 0,
            coordinateSpace: .local
        )
        .onChanged { gesture in
            if gesture.translation.height < 0 {
                gestureOffset = gesture.translation
                position =  gesture.location
                if gestureOffset.height < -60 {
                    print("Should be pulled")
                } else {
                    print("Should be put back")
                }
            }
            if gesture.translation.height > 0 {
                gestureOffset = gesture.translation
                position =  gesture.location
            }
            print(gestureOffset.height)
            
        }
        .onEnded { value in
            withAnimation(.easeIn) {
                if gestureOffset.height > 60 {
                }
                if gestureOffset.height < -100 {
//                    isPulled.toggle()
                }
                
//                gestureOffset = isPulled ? .init(width: gestureOffset.width, height: 200) : .zero
            }
        }
        /*
        let impactHeavy = UIImpactFeedbackGenerator(style: .rigid)
        let longPress = LongPressGesture(minimumDuration: 0.2)
            .onChanged { _ in
                impactHeavy.impactOccurred()
            }
            .onEnded { _ in
//                message = "Now drag me"
                let _ = print("Now drag me")
        }
        
        let drag = DragGesture(
            minimumDistance: 0,
            coordinateSpace: .global
        )
            .onChanged { gesture in
//                currentPosition = gesture.location
                
                if gesture.translation.height < 0 {
                    if isPulled {
                        gestureOffset = .init(width: gesture.translation.width, height: gesture.translation.height - 400)
                    } else {
                        gestureOffset = gesture.translation
                    }
                    
                    scale = 1.0 + abs(gesture.translation.height / 100)
//                    print("scale: \(scale)")
                    if gestureOffset.height > 60 {
//                        print("Should remove from scrollview")
                        withAnimation {
//                            viewModel.pull(index)
                        }
                    }
                }
                
//                if gesture.translation.height > 0 {
                    gestureOffset = gesture.translation
//                }
                
//                print("gesture height:", gestureOffset.height)
//                print("gesture translation:", gesture.translation.height)
            }
            .onEnded { value in
                withAnimation(.easeIn) {
                    if gestureOffset.height > 60 {
//                        viewModel.deleteHandler?(index)
//                        activeID = max(0, index - 1)
                    }
                    else if gestureOffset.height < -100 {
                        isPulled.toggle()
                        print("move to position")
                        scale = 3.5
                    }
                    else {
//                        viewModel.push(index)
                        gestureOffset = .zero
                        scale = 1.0
                    }
                }
            }
        
        let combined = longPress.sequenced(before: drag)
        return combined
         */
    }
}

#Preview {
    ContentView()
}
