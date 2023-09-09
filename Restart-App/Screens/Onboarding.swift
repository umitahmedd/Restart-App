   //
   //  Onboarding.swift
   //  Restart-App
   //
   //  Created by mac on 8.09.2023.
   //

import SwiftUI

struct Onboarding: View {
   @AppStorage("onboarding") var isOnBoardingActive:Bool = true
   @State private var buttonWidth:CGFloat = UIScreen.main.bounds.width - 110
   @State private var buttonOffset:CGFloat = 0
   private let feedbackGenerator = UINotificationFeedbackGenerator()
   private let generator = UIImpactFeedbackGenerator(style: .heavy)
   @State private var isAnimation = false
   @State private var imageOffset:CGSize = .zero
   @State private var indicatorOpacity:Double = 1.0
   @State private var textTitle:String = "Share."
   
   var body: some View {
      ZStack{
         Color("ColorBlue")
            .ignoresSafeArea(.all)
         
         VStack{
               // MARK: HEADER
            VStack{
               Text(textTitle)
                  .fontWeight(.heavy)
                  .font(.system(size: 60))
                  .foregroundColor(.white)
                  .transition(.opacity)
                  .id(textTitle)
               
               Text(" it's not how much we give birds how much love we put into giving")
                  .font(.title2)
                  .fontWeight(.light)
                  .multilineTextAlignment(.center)
                  .padding(.horizontal, 20)
                  .foregroundColor(.white)
               
            }
            .opacity(isAnimation ? 1 : 0)
            .offset(y: isAnimation ? 0 : -50)
            .animation(.easeOut(duration: 1), value: isAnimation)
               //: HEADER
            
            Spacer()
            
               // MARK: CENTER
            ZStack{
              
               CircleGroup(ShapeColor: .white, ShapeOpacity: 0.2)
                  .blur(radius: abs(imageOffset.width/30))
                  .offset(x: imageOffset.width * -1)
                  .animation(.easeOut(duration: 1), value: imageOffset)


               
               Image("character-1")
                  .resizable()
                  .scaledToFit()
                  .padding(30)
                  .scaleEffect(isAnimation ? 1 : 0.9)
                  .animation(.easeOut(duration: 1), value: isAnimation)
                  .offset(x: imageOffset.width * 1.2, y: 0 )
                  .rotationEffect(.degrees(Double(imageOffset.width/20)))
                  .gesture(
                  DragGesture()
                     .onChanged{ gesture in
                        if abs(imageOffset.width) <= 150 {
                           imageOffset = gesture.translation
                           withAnimation(.linear(duration: 0.25)){
                              indicatorOpacity = 0
                              textTitle = "Give."
                           }
                        }
                     }
                     .onEnded{ _ in
                        imageOffset = .zero
                        withAnimation(.linear(duration: 0.25)){
                           indicatorOpacity = 1
                           textTitle = "Share."
                        }
                     }
                  )
                  .animation(.easeOut(duration: 0.7), value: imageOffset)
               
            } //: CENTER
            .overlay(
            Image(systemName: "arrow.left.and.right.circle")
               .font(.system(size: 44, weight: .ultraLight))
               .foregroundColor(.white)
               .offset(y: -20)
               .opacity(isAnimation ? 1 : 0)
               .animation(.easeOut(duration: 1) .delay(1), value: isAnimation)
               .opacity(indicatorOpacity)
            ,alignment: .bottom
            )
            
            
            Spacer()
            
               // MARK: FOOTER
            ZStack{
               Text("Get Started")
                  .foregroundColor(.white)
                  .font(.system(.title3, design: .rounded))
                  .bold()
                  .offset(x:20)
               ZStack{
                  Capsule()
                     .fill(.white.opacity(0.2))
                  
                  Capsule()
                     .fill(.white.opacity(0.2))
                     .padding(8)
                  
                  HStack{
                     Capsule()
                        .fill(Color("ColorRed"))
                        .frame(width: buttonOffset + 80)
                     Spacer()
                  }
                   
                  
                  HStack {
                     ZStack{
                        Circle()
                           .fill(Color("ColorRed"))
                           .padding()
                        
                        Circle()
                           .fill(.black.opacity(0.15))
                           .padding(8)
                        
                        Image(systemName: "chevron.right.2")
                           .foregroundColor(.white)
                           .font(.system(size: 30 , weight: .bold))
                           .rotationEffect(.degrees(buttonOffset / 2))
                        
                     }
                     .rotationEffect(.degrees(buttonOffset))
                     .offset(x: buttonOffset)
                     .gesture(
                     DragGesture()
                        .onChanged{ gesture in
                           if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                              buttonOffset = gesture.translation.width
                           }
                        }
                        .onEnded{_ in
                           if buttonOffset < buttonWidth/2 {
                              withAnimation(.easeInOut(duration: 0.5)){
                                 buttonOffset = 0
                                 feedbackGenerator.notificationOccurred(.warning)
                              }
                           }
                           else{
                              withAnimation(.easeOut(duration: 0.5)){
                                 buttonOffset = buttonWidth - 80
                                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    feedbackGenerator.notificationOccurred(.success)
                                    withAnimation(.easeOut(duration: 0.25)){
                                       isOnBoardingActive = false
                                    }
                                    playSound(sound: "chimeup", type: "mp3")
                                 }
                              }
                               
                           }
                           
                        }
                     )
                     Spacer()
                  }
                  

               }
            } //: FOOTER
            .frame( maxWidth: buttonWidth, maxHeight: 80)
            .padding(.horizontal)
            .opacity(isAnimation ? 1 : 0)
            .offset(y: isAnimation ? 0 : 50)
            .animation(.easeOut(duration: 1), value: isAnimation)
            
         }
      }
      .onAppear(perform: {
         isAnimation = true
      })
   }
}

struct Onboarding_Previews: PreviewProvider {
   static var previews: some View {
      Onboarding()
   }
}
