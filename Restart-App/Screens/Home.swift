   //
   //  Home.swift
   //  Restart-App
   //
   //  Created by mac on 8.09.2023.
   //

import SwiftUI

struct Home: View {
   @AppStorage("onboarding") var isOnBoardingActive:Bool = false
   @State private var isAnimation:Bool = false
   private let feedbackGenerator = UINotificationFeedbackGenerator()
   
   var body: some View {
      VStack{
         Spacer()
         ZStack {
            CircleGroup(ShapeColor: .gray, ShapeOpacity: 0.1)
            
            Image("character-2")
               .resizable()
               .scaledToFit()
               .padding()
               .offset(y: isAnimation ? 30 : -30)
               .animation(Animation.easeOut(duration: 4) .repeatForever(), value: isAnimation)
         }
         
         Text("The time that leads to mastery is dependent on the intensity of our focus")
            .font(.system(.title3))
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding()
         
         Spacer()
         
         Button(action: {
            withAnimation(.easeOut(duration: 5)){
               playSound(sound: "success", type: "m4a")
               isOnBoardingActive = true
               feedbackGenerator.notificationOccurred(.success)
            }
         }){
            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
               .imageScale(.large)
            
            Text("Restart")
               .fontWeight(.bold)
               .font(.system(.title3, design: .rounded))
         }
         .buttonStyle(.borderedProminent)
         .buttonBorderShape(.capsule)
         .controlSize(.large)
         
      }
      .onAppear(perform: {
         DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            isAnimation = true
         })
      })
   }
}

struct Home_Previews: PreviewProvider {
   static var previews: some View {
      Home()
   }
}

