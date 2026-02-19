import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            MindView()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Mind")
                }
            
            HealthView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Health")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(.green) // Active tab f
    }
}

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome Back")
                    .font(.title)
                Text("Your daily summary will appear here.")
                    .foregroundColor(.gray)
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct MindView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Mental Wellness")
                    .font(.title)
            }
            .navigationTitle("Mind")
        }
    }
}

struct HealthView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Health Tracking")
                    .font(.title)
            }
            .navigationTitle("Health")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("App Settings")
                    .font(.title)
            }
            .navigationTitle("Settings")
        }
    }
}
