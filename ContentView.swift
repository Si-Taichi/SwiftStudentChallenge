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
    @AppStorage("userName") var name = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Welcome Back, \(name)")
                    .font(.title)
                Text("Your daily summary will appear here.")
                    .foregroundColor(.gray)
            }
            .navigationTitle("Home")
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
            VStack(spacing: 20) {
                Text("App Settings")
                    .font(.title)
                Button("Send Test Notification (5s)") {
                    NotificationManager.shared.sendTestNotification()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}
