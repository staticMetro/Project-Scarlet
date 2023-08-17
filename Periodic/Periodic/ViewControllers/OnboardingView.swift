//
//  OnboardingView.swift
//  Periodic
//
//  Created by Aimeric on 6/22/23.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        Text("Welcome Home !!!")
            .font(.title)
            .fontWeight(.heavy)
    }
}

struct OnboardingView: View {
    @AppStorage("currentPage") var currentPage = 1

    var body: some View {
        
        if currentPage > totalPages {
            Home()
        } else { WalkthroughScreen() }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
struct WalkthroughScreen: View {
    @AppStorage("currentPage") var currentPage = 1

    var body: some View {
        // For Slide Animation
        ZStack {
            if currentPage == 1 {
                ScreenView(image: "onboard", title: "Step 1", detail: "fidahlifhaifhasud", bgColor: "PrimaryColor")
                    .transition(.scale)
            }
            if currentPage == 2 {
                ScreenView(image: "onboard", title: "Step 2", detail: "fidahlifhaifhasud", bgColor: "TitleTextColor")
                    .transition(.scale)

            }
            if currentPage == 3{
                ScreenView(image: "onboard", title: "Step 3", detail: "fidahlifhaifhasud", bgColor: "systemgreen")
                    .transition(.scale)

            }

        }
        .overlay(
            // Button
            Button(action: {
                //changing views
                withAnimation(.easeInOut) {
                    if currentPage <= totalPages {
                        currentPage += 1
                    } else {currentPage = 1}
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())

                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom, 20)
            ,alignment: .bottom
        )
    }
}

struct ScreenView: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: String
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                if currentPage == 1 {
                    Text("Hello There!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    // Letter Spacing
                        .kerning(1.4)
                }
                else {
                    Button(action: {//changing views
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }}, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.4))
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .cornerRadius(10)
                    })
                }
            
                Spacer()

                Button(action: {}, label:  {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
        
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            // detail
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            Spacer(minLength: 120)
        }
        // bgcolor
        .background(Color("PrimaryColor").cornerRadius(10).ignoresSafeArea())
    }
}
var totalPages = 3
