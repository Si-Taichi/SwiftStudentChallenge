import SwiftUI

@main
struct MyApp: App {
    
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView()
            } else {
                OnboardingView()
            }
        }
    }
}

struct OnboardingView: View {
    
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @State private var currentStep = 0
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if currentStep == 0 {
                WelcomeStep()
            }
            
            if currentStep == 1 {
                AgeStep()
            }
            
            if currentStep == 2 {
                FocusStep()
            }
            
            Spacer()
            
            Button(action: nextStep) {
                Text(currentStep == 2 ? "Finish" : "Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding()
        }
        .padding()
        .animation(.easeInOut, value: currentStep)
    }
    
    func nextStep() {
        if currentStep < 2 {
            currentStep += 1
        } else {
            hasCompletedOnboarding = true
        }
    }
}

struct WelcomeStep: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
                .font(.largeTitle)
            
            Text("Let’s personalize your experience.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

struct AgeStep: View {
    
    @State private var selectedAge = 45
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your Age")
                .font(.title)
            
            Stepper("Age: \(selectedAge)", value: $selectedAge, in: 35...65)
                .padding()
        }
    }
}

struct FocusStep: View {
    
    @State private var selectedFocus = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What would you like to focus on?")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            OptionButton(title: "Mental Health", selected: $selectedFocus)
            OptionButton(title: "Physical Health", selected: $selectedFocus)
            OptionButton(title: "Work-Life Balance", selected: $selectedFocus)
        }
    }
}

struct OptionButton: View {
    let title: String
    @Binding var selected: String
    
    var body: some View {
        Button(action: {
            selected = title
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selected == title ? Color.green.opacity(0.3) : Color.gray.opacity(0.1))
                .cornerRadius(12)
        }
    }
}
