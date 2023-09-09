   //
   //  CircleGroup.swift
   //  Restart-App
   //
   //  Created by mac on 8.09.2023.
   //

import SwiftUI

struct CircleGroup: View {
   @State var ShapeColor: Color
   @State var ShapeOpacity: CGFloat
   @State private var isAnimation = false
   var body: some View {
      ZStack{
         Circle()
            .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
            .frame(width: 260, height: 260)
         
         Circle()
            .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
            .frame(width: 260, height: 260)
      }
      .blur(radius: isAnimation ? 0 : 10)
      .opacity( isAnimation ? 1 : 0)
      .scaleEffect(isAnimation ? 1 : 0.5)
      .animation(.easeOut(duration: 1), value: isAnimation)
      .onAppear(perform: {
         isAnimation = true
      })
   }
}

struct CircleGroup_Previews: PreviewProvider {
   static var previews: some View {
      ZStack {
         Color("ColorBlue")
            .ignoresSafeArea(.all, edges: .all)
         CircleGroup(ShapeColor: .white, ShapeOpacity: 0.2)
      }
   }
}
