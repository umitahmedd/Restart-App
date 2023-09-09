//
//  ContentView.swift
//  Restart-App
//
//  Created by mac on 8.09.2023.
//

import SwiftUI

struct ContentView: View {
   @AppStorage("onboarding") var isOnBoardingActive:Bool = true
    var body: some View {
       if isOnBoardingActive{
          Onboarding()
       }
       else{
          Home()
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
