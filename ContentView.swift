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
    
    @State private var questions: [Question] = []
    @State private var showThankYou = false
    @State private var currentPeriod: CheckInPeriod?
    @State private var shouldShowQuestion = false
        
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                
                Text("Welcome Back, \(name)")
                    .font(.title)
                
                if shouldShowQuestion, let period = currentPeriod {
                    
                    Text(titleForPeriod(period))
                        .font(.headline)
                    
                    ForEach(questions) { question in
                        VStack(spacing: 12) {
                            
                            Text(question.text)
                            
                            ForEach(question.options) { option in
                                Button {
                                    saveMood(option.value, question: question.text, period: period)
                                } label: {
                                    Text(option.text)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.green.opacity(0.15))
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                }
                else {
                    Text("You've completed your check-in for this period 💚")
                        .foregroundColor(.gray)
                }
                
            if showThankYou {
                Text("Thanks for sharing 💚")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .onAppear {
                moodEntries = MoodManager.shared.loadEntries()
                currentPeriod = CheckInPeriod.current()
                
                if let period = currentPeriod {
                    shouldShowQuestion = !MoodManager.shared.hasAnsweredToday(for: period)
                }
            }
        }
    }
    
    func saveMood(_ value: String, question: String, period: CheckInPeriod) {
        
        let entry = MoodEntry(
            date: Date(),
            period: period.rawValue,
            question: question,
            value: value
        )
        
        MoodManager.shared.saveEntry(entry)
        
        shouldShowQuestion = false
    }

    func titleForPeriod(_ period: CheckInPeriod) -> String {
        switch period {
        case .morning:
            return "Good Morning ☀️ How are you feeling?"
        case .afternoon:
            return "Good Afternoon 🌤 How are you feeling?"
        case .evening:
            return "Good Evening 🌙 How are you feeling?"
        }
    }
}

struct MoodButton: View {
    
    var text: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color.opacity(0.2))
                .foregroundColor(color)
                .cornerRadius(12)
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
    
    @State private var entries: [HealthEntry] = []
    @State private var showAddEntry = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if entries.isEmpty {
                    Text("No health records yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(entries) { entry in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                if let sugar = entry.bloodSugar {
                                    Text("Blood Sugar: \(sugar)")
                                }
                                
                                if let pressure = entry.bloodPressure {
                                    Text("Blood Pressure: \(pressure)")
                                }
                                
                                if let fat = entry.bodyFat {
                                    Text("Body Fat: \(fat)%")
                                }
                                
                                Text("BMI: \(String(format: "%.1f", entry.bmi))")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Health")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddEntry = true
                    } label: {
                        Image(systemName: "plus").padding(20)
                    }
                }
            }
            .onAppear {
                entries = HealthEntryManager.shared.loadEntries()
            }
            .sheet(isPresented: $showAddEntry) {
                AddHealthEntryView {
                    entries = HealthEntryManager.shared.loadEntries()
                }
            }
        }
    }
}

struct AddHealthEntryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("userHeight") var height = 170
    @AppStorage("userWeight") var weight = 65
    
    @State private var bloodSugar = ""
    @State private var bloodPressure = ""
    @State private var bodyFat = ""
    @State private var showAlert = false
    
    var onSave: () -> Void
    
    var bmi: Double {
        let heightInMeters = Double(height) / 100
        return Double(weight) / (heightInMeters * heightInMeters)
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Health Data")) {
                    
                    TextField("Blood Sugar (mg/dL)", text: $bloodSugar)
                        .keyboardType(.decimalPad)
                    
                    TextField("Blood Pressure (e.g. 120/80)", text: $bloodPressure)
                    
                    TextField("Body Fat (%)", text: $bodyFat)
                        .keyboardType(.decimalPad)
                    
                    HStack {
                        Text("BMI")
                        Spacer()
                        Text(String(format: "%.1f", bmi))
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEntry()
                    }
                }
            }
            .alert("Please fill at least one field.", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    func saveEntry() {
        
        if bloodSugar.isEmpty && bloodPressure.isEmpty && bodyFat.isEmpty {
            showAlert = true
            return
        }
        
        let entry = HealthEntry(
            date: Date(),
            bloodSugar: bloodSugar.isEmpty ? nil : bloodSugar,
            bloodPressure: bloodPressure.isEmpty ? nil : bloodPressure,
            bodyFat: bodyFat.isEmpty ? nil : bodyFat,
            bmi: bmi
        )
        
        HealthEntryManager.shared.saveEntry(entry)
        onSave()
        dismiss()
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
