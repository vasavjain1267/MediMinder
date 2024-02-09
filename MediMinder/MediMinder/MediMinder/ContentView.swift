//
//  ContentView.swift
//  MediMinder
//
//  Created by Vasav Jain on 09/02/24.
//

//
//  ContentView.swift
//  medicarerough2
//
//  Created by Vasav Jain on 02/02/24.
//

import SwiftUI
import SwiftData
//import Cocoa


struct Medication {
    var name: String
    var unit: Int
    var frequency: Int
}
struct ContentView: View {
    @State var medications: [Medication] = []
    @State var isAddingMedication = false
    @State var medicationName = ""
    @State var selectedUnitIndex = 0
    @State var selectedFrequencyIndex = 0
     let frequencies = ["Every Day", "Every X Days", "Day of Week", "Day of Month"]
    @State var numberOfDays = 2
    @State var selectedDaysOfWeek: [Bool] = [false, false, false, false, false, false, false]
     let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @State var selectedDaysOfMonth: [Bool] = Array(repeating: false, count: 31)
    @State var isAfterBreakfastSelected = false
    @State var isAfterLunchSelected = false
    @State var isAfterDinnerSelected = false
    @State var isBeforeBreakfastSelected = false
    @State var isBeforeLunchSelected = false
    @State var isBeforeDinnerSelected = false
    @State var isRandomTimeSelected = false
    @State var selectedRandomTime = Date()
    @State var selectedBreakfastTime = Date()
    @State var selectedLunchTime = Date()
    @State var selectedDinnerTime = Date()
    @State var selectedRandomTimes: [Date] = []
   
    var body: some View {
        NavigationView {
//            ZStack{
//                LinearGradient(colors:[.blue, .black],startPoint: .topLeading, endPoint: .bottomTrailing)
                
                VStack {
                    
                    Image("pill")
                        .resizable()
                        .frame(width:400, height:300)
                        .cornerRadius(10)
                        .rotationEffect(.zero)
            
                    
                    Spacer()
                    HStack{
                        
                        Button(
                            action: {
                                
                                
                            },
                            label:{
                                Text("Medi")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .frame(width: 125,height: 75)
                                    .fontWeight(.semibold)
                                
                            }
                        )
                        .background(.blue)
                        .cornerRadius(10)
                        Button(
                            action: {
                                
                            },
                            label:{
                                Text("cation")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .frame(width: 125,height: 75)
                                    .fontWeight(.semibold)
                                
                            }
                        )
                        .background(.gray)
                        .cornerRadius(10)
                    }
                    HStack{
                        
                        Button(
                            action: {
                                
                            },
                            label:{
                                Text("Re")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .frame(width: 75,height: 75)
                                    .fontWeight(.semibold)
                                
                            }
                        )
                        .background(.gray)
                        .cornerRadius(10)
                        Button(
                            action: {
                                
                            },
                            label:{
                                Text("Minder")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .frame(width: 145,height: 75)
                                    .fontWeight(.semibold)
                                
                            }
                        )
                        .background(.blue)
                        .cornerRadius(10)
                        
                    }
                    
                    //                    .accessibilityHidden(true)
                    //                    .accessibilityLabel("Label")
                    //                    .accessibilityHint("Hint")
                    
                    NavigationLink(destination: MedicationFormView(medicationName: $medicationName, selectedUnitIndex: $selectedUnitIndex, medications: medications), isActive: $isAddingMedication) {
                        EmptyView()
                    }
                    Spacer()
                    Button(
                        action:{
                            self.isAddingMedication = true
                        },
                        label:{
                            Text("Add Medication")
                                .frame(width: 350,height: 75)
                                .fontWeight(.semibold)
                                .font(.headline)
                                .foregroundColor(.white)
                                
                        }
                        
                    )
                    .background(.blue)
                    .cornerRadius(25)
                                    Spacer()
                }
                //            .navigationBarTitle("Medicine Reminder")
                .environmentObject(MedicationData())
//            }
            .edgesIgnoringSafeArea(.all)
        }
        .padding()
            
            
//        .frame(width: 18.0)
    }
    class MedicationData: ObservableObject {
        @Published var medications: [Medication] = []

        func addMedication(medication: Medication) {
            medications.append(medication)
        }
    }
}
struct MedicationFormView: View {
    @Binding var medicationName: String
    @Binding var selectedUnitIndex: Int
     let units = ["Pills", "Tablets", "Drops", "ml","capsules", "sachet", "spray", "Injections"]
    
    @State var selectedFrequencyIndex = 0
     let frequencies = ["Every Day", "Every X Days", "Day of Week", "Day of Month"]
    
    @State var numberOfDays = 2
    
    @State var selectedDaysOfWeek: [Bool] = [false, false, false, false, false, false, false]
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    @State var selectedDaysOfMonth: [Bool] = Array(repeating: false, count: 31)
    
    @State var isFrequencyFormPresented = false
    
    @State var isAlertPresented = false
    
    @State var medications: [Medication]
    var body: some View {
        Form {
                    Section(header: Text("Medication Details")) 
            {
                        TextField("Medication Name", text: $medicationName)
                        Picker("Unit", selection: $selectedUnitIndex) {
                            ForEach(0..<units.count) {
                                Text(self.units[$0])
                                
                            }
                        }
                    }
//
//            Section(header: Text("Frequency")) {
//                Picker("Select Frequency", selection: $selectedFrequencyIndex) {
//                    ForEach(0..<frequencies.count) {
//                        Text(self.frequencies[$0])
//
//                    }
//                }
//            }
//
            HStack {
                Spacer()
                Button("Add Frequency") {
                    if !self.medicationName.isEmpty {
                        self.isFrequencyFormPresented = true
                        
                    }
                    else {
                        self.isAlertPresented = true
                    }
                }
                Spacer()
            }
                }
        NavigationLink(destination: MedicationFrequencyFormView(selectedFrequencyIndex: $selectedFrequencyIndex, numberOfDays: $numberOfDays, selectedDaysOfWeek: $selectedDaysOfWeek, selectedDaysOfMonth: $selectedDaysOfMonth, medications: medications, medicationName: medicationName, selectedUnitIndex: selectedUnitIndex), isActive: $isFrequencyFormPresented) {
            EmptyView()
        }
        .navigationBarTitle("Add Medication")
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text("Please Enter Medication Name"), dismissButton: .default(Text("OK")))
        }
    }
}
struct MedicationFrequencyFormView: View {
    @Binding var selectedFrequencyIndex: Int
    let frequencies = ["Every Day", "Every X Days", "Day of Week", "Day of Month"]
    
    @Binding var numberOfDays: Int
    
    @Binding var selectedDaysOfWeek: [Bool] /*= [false, false, false, false, false, false, false]*/
        let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    @Binding var selectedDaysOfMonth: [Bool] /*= Array(repeating: false, count: 31)*/
    
    @State var isScheduleFormPresented = false
    @State var isAlertPresented2 = false
    @State var isAlertPresented1 = false
    @State var isAfterBreakfastSelected = false
    @State var isAfterLunchSelected = false
    @State var isAfterDinnerSelected = false
    @State var isBeforeBreakfastSelected = false
    @State var isBeforeLunchSelected = false
    @State var isBeforeDinnerSelected = false
    @State var isRandomTimeSelected = false
    @State var selectedRandomTime = Date()
    @State var selectedBreakfastTime = Date()
    @State var selectedLunchTime = Date()
    @State var selectedDinnerTime = Date()
    @State var selectedRandomTimes: [Date] = []
    @State var medications: [Medication]
    var medicationName: String
    var selectedUnitIndex: Int
    var body: some View {
        Form {
            Section(header: Text("Frequency")) {
                Picker("Select Frequency", selection: $selectedFrequencyIndex) {
                    ForEach(0..<frequencies.count) {
                        Text(self.frequencies[$0])
                       
                    }
                }
            }
            if selectedFrequencyIndex == 1 { // Every X Days
                            Section(header: Text("Repeat Every X Days")) {
                                Stepper(value: $numberOfDays, in: 2...365, step: 1) {
                                    Text("\(numberOfDays) days")
                                }
                            }
                        } else if selectedFrequencyIndex == 2 { // Day of Week
                            Section(header: Text("Select Days of Week")) {
                                ForEach(0..<daysOfWeek.count) { index in
                                    Toggle(daysOfWeek[index], isOn: $selectedDaysOfWeek[index])
                                }
                            }
                        }
            else if selectedFrequencyIndex == 3 { // Day of Month
                            Section(header: Text("Select Days of Month")) {
                                    ForEach(1...31, id: \.self) { day in
                                    Toggle("\(day)", isOn: $selectedDaysOfMonth[day - 1])
                                    }
                            }
                        }            // You can add more sections for additional frequency details based on the selected option.
        }
        .navigationBarTitle("Frequency")
        Button("Next") {
                        if selectedFrequencyIndex == 3 && selectedDaysOfMonth.filter({ $0 }).isEmpty {
                            // Ensure at least one day is selected for Day of Month
                            self.isAlertPresented2 = true
                        }
            else if selectedFrequencyIndex == 2 && selectedDaysOfWeek.filter({ $0 }).isEmpty {
                // Ensure at least one day is selected for Day of Week
                self.isAlertPresented1 = true}
            else {
                            self.isScheduleFormPresented = true
                        }
                    }
//        .sheet(isPresented: $isScheduleFormPresented) {
        NavigationLink(destination: MedicationScheduleFormView(isAfterBreakfastSelected: $isAfterBreakfastSelected, isAfterLunchSelected: $isAfterLunchSelected, isAfterDinnerSelected: $isAfterDinnerSelected, isBeforeBreakfastSelected: $isBeforeBreakfastSelected, isBeforeLunchSelected: $isBeforeLunchSelected, isBeforeDinnerSelected: $isBeforeDinnerSelected, isRandomTimeSelected: $isRandomTimeSelected, selectedRandomTime: $selectedRandomTime, selectedBreakfastTime: $selectedBreakfastTime, selectedLunchTime: $selectedLunchTime, selectedDinnerTime: $selectedDinnerTime, selectedRandomTimes: $selectedRandomTimes, medicationName: medicationName, selectedUnitIndex: selectedUnitIndex, selectedFrequencyIndex: selectedFrequencyIndex, numberOfDays: numberOfDays, selectedDaysOfWeek: selectedDaysOfWeek, selectedDaysOfMonth: selectedDaysOfMonth, medications: medications), isActive: $isScheduleFormPresented) {
                EmptyView()
            }
//                }
                .alert(isPresented: $isAlertPresented2) {
                    Alert(title: Text("Please Select Atleast One Day Of Month"), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $isAlertPresented1) {
                            Alert(title: Text("Please Select Atleast One Day Of Week"), dismissButton: .default(Text("OK")))
                }
    }
}
struct MedicationScheduleFormView: View {
    
    @Binding var isAfterBreakfastSelected: Bool
    @Binding var isAfterLunchSelected: Bool
    @Binding var isAfterDinnerSelected: Bool
    @Binding var isBeforeBreakfastSelected: Bool
    @Binding var isBeforeLunchSelected: Bool
    @Binding var isBeforeDinnerSelected: Bool
    @Binding var isRandomTimeSelected: Bool
    @Binding var selectedRandomTime: Date
    @Binding var selectedBreakfastTime: Date
    @Binding var selectedLunchTime: Date
    @Binding var selectedDinnerTime: Date
    @Binding var selectedRandomTimes: [Date]
    @State var showAddRandomTimeSheet = false
    @State var selectedTime = Date()
    @State var isAlertPresented = false
    @State var isSummaryViewPresented = false
//    @State private var selectedTab = 0
    @State private var isReminderSet = false
    var medicationName: String
    var selectedUnitIndex: Int
    var selectedFrequencyIndex: Int
//     let frequencies = ["Every Day", "Every X Days", "Day of Week", "Day of Month"]
    var numberOfDays: Int
    var selectedDaysOfWeek: [Bool] /*= [false, false, false, false, false, false, false]*/
//     let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectedDaysOfMonth: [Bool] /*= Array(repeating: false, count: 31)*/
    @State var medications: [Medication]
    var body: some View {
        Form {
                    Section(header: Text("Schedule Mode")) {
                        Toggle("After Breakfast", isOn: $isAfterBreakfastSelected)
                            .disabled(isRandomTimeSelected)
                            .disabled(isBeforeBreakfastSelected)
                        Toggle("After Lunch", isOn: $isAfterLunchSelected)
                            .disabled(isRandomTimeSelected)
                            .disabled(isBeforeLunchSelected)
                        Toggle("After Dinner", isOn: $isAfterDinnerSelected)
                            .disabled(isRandomTimeSelected)
                            .disabled(isBeforeDinnerSelected)
                        Toggle("Before Breakfast", isOn: $isBeforeBreakfastSelected)
                            .disabled(isRandomTimeSelected)
                            .disabled(isAfterBreakfastSelected)
                        Toggle("Before Lunch", isOn: $isBeforeLunchSelected)
                            .disabled(isRandomTimeSelected)
                            .disabled(isAfterLunchSelected)
                        Toggle("Before Dinner", isOn: $isBeforeDinnerSelected)
                            .disabled(isRandomTimeSelected)
                            .disabled(isAfterDinnerSelected)
                        Toggle("Set Random Time", isOn: $isRandomTimeSelected)
                            .onChange(of: isRandomTimeSelected) { newValue in
                                // Reset other selections if Set Random Time is selected
                                if newValue {
                                    isAfterBreakfastSelected = false
                                    isAfterLunchSelected = false
                                    isAfterDinnerSelected = false
                                    isBeforeBreakfastSelected = false
                                    isBeforeLunchSelected = false
                                    isBeforeDinnerSelected = false
                                }
                            }
                    }

                    // Additional section for Set Random Time
            if isAfterBreakfastSelected {
                Section(header: Text("Notification Time After Breakfast")) {
                    DatePicker("Random Time", selection: $selectedBreakfastTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            if isAfterLunchSelected {
                Section(header: Text("Notification Time After Lunch")) {
                    DatePicker("Random Time", selection: $selectedLunchTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            if isAfterDinnerSelected {
                Section(header: Text("Notification Time After Dinner")) {
                    DatePicker("Random Time", selection: $selectedDinnerTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            if isBeforeBreakfastSelected {
                Section(header: Text("Notification Time Before Breakfast")) {
                    DatePicker("Random Time", selection: $selectedBreakfastTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            if isBeforeLunchSelected {
                Section(header: Text("Notification Time Before Lunch")) {
                    DatePicker("Random Time", selection: $selectedLunchTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            if isBeforeDinnerSelected {
                Section(header: Text("Notification Time Before Dinner")) {
                    DatePicker("Random Time", selection: $selectedDinnerTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
                    if isRandomTimeSelected {
                        Section(header: Text("Choose Random Time To Notify")) {
                            DatePicker("Random Time", selection: $selectedRandomTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
//                            Button("Add Random Time") {
//                                                    showAddRandomTimeSheet = true
//                                                }
//                                                .actionSheet(isPresented: $showAddRandomTimeSheet) {
//                                                    ActionSheet(
//                                                        title: Text("Add Random Time"),
//                                                        buttons: [
//                                                            .default(Text("Add Time")) {
//                                                                // Show a time picker to add a new random time
//                                                                showTimePicker()
//                                                            },
//                                                            .cancel()
//                                                        ]
//                                                    )
//                                                }
                        }
                    }
            Button(action: {
                isReminderSet.toggle()
            }
            )
            {
                Text(isReminderSet ? "Reminder Set" : "Set Reminder")
                    .foregroundColor(.white)
                    .padding()
                    .background(isReminderSet ? Color.green : Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            Section {
                
                                Button("View Task") {
                                    // Validate data and present summary view
                                    validateAndPresentSummaryView()
                                }
                            }
            
                }
        .navigationBarTitle("Schedule Mode")
//        .sheet(isPresented: $showAddRandomTimeSheet) {
//                        NavigationView {
//                            TimePickerView(selectedTime: $selectedTime, addRandomTime: { time in
//                                // Add the selected time to the list if it's not already in the list
//                                if !selectedRandomTimes.contains(time) {
//                                    selectedRandomTimes.append(time)
//                                }
//
//                                // Limit to 6 random times
//                                if selectedRandomTimes.count > 6 {
//                                    selectedRandomTimes.removeFirst()
//                                }
//
//                                // Dismiss the sheet
//                                showAddRandomTimeSheet = false
//                            })
//                        }
//                    }
//                    .alert(isPresented: $isAlertPresented) {
//                        Alert(title: Text("Error"), message: Text("Please fill in all required fields."), dismissButton: .default(Text("OK")))
//                    }
                    .background(
                        NavigationLink(
                            destination: MedicationSummaryView(medicationName: medicationName, selectedUnitIndex: selectedUnitIndex, selectedFrequencyIndex: selectedFrequencyIndex, numberOfDays: numberOfDays, selectedDaysOfWeek: selectedDaysOfWeek, selectedDaysOfMonth: selectedDaysOfMonth, isAfterBreakfastSelected: isAfterBreakfastSelected, isAfterLunchSelected: isAfterLunchSelected, isAfterDinnerSelected: isAfterDinnerSelected, isBeforeBreakfastSelected: isBeforeBreakfastSelected, isBeforeLunchSelected: isBeforeLunchSelected, isBeforeDinnerSelected: isBeforeDinnerSelected, isRandomTimeSelected: isRandomTimeSelected, selectedRandomTime: selectedRandomTime, selectedBreakfastTime: selectedBreakfastTime, selectedLunchTime: selectedLunchTime, selectedDinnerTime: selectedDinnerTime, selectedRandomTimes: selectedRandomTimes, medications: $medications),
                            isActive: $isSummaryViewPresented,
                            label: EmptyView.init
                        )
                    )
    }
    func validateAndPresentSummaryView() {
            // Validate data before presenting the summary view
//            guard !medicineName.isEmpty, !selectedRandomTimes.isEmpty else {
//                // Show an alert if data is not valid
//                isAlertPresented = false
//                return
//            }

            // Present the summary view
            isSummaryViewPresented = true
        }
//    func showTimePicker() {
//        @State var currentTime = Date()
//            // Show a time picker
//           let timePicker = DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
////        print("Helow")
////        Section (header: Text ("Date Picker 4")) {
////        DatePicker("Pick a future date:", selection:
////                    $currentTime, displayedComponents: .date).labelsHidden()
////        }
//            #if os(iOS)
//            timePicker.datePickerStyle(WheelDatePickerStyle())
////            print("Hello")
//            #endif
//            DatePicker("Random Time", selection: $selectedRandomTime, displayedComponents: .hourAndMinute)
//            .labelsHidden()
//             Add the selected time to the list if it's not already in the list
//            print("Helloworld")
//            if !selectedRandomTimes.contains(selectedTime) {
//                selectedRandomTimes.append(selectedTime)
//            }
//
//            // Limit to 6 random times
//            if selectedRandomTimes.count > 6 {
//                selectedRandomTimes.removeFirst()
//            }
//        }
     func formatTime(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
}
struct MedicationSummaryView: View {
    var medicationName: String
    var selectedUnitIndex: Int
    var selectedFrequencyIndex: Int
     let frequencies = ["Every Day", "Every X Days", "Day of Week", "Day of Month"]
    var numberOfDays: Int
    var selectedDaysOfWeek: [Bool]
//    let trueIdxs = selectedDaysOfWeek.enumerate().flatmap{$1 ? $0 : nil }
     let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectedDaysOfMonth: [Bool] /*= Array(repeating: false, count: 31)*/
    var isAfterBreakfastSelected: Bool
    var isAfterLunchSelected: Bool
    var isAfterDinnerSelected: Bool
    var isBeforeBreakfastSelected: Bool
    var isBeforeLunchSelected: Bool
    var isBeforeDinnerSelected: Bool
    var isRandomTimeSelected: Bool
    var selectedRandomTime: Date
    var selectedBreakfastTime: Date
    var selectedLunchTime: Date
    var selectedDinnerTime: Date
    var selectedRandomTimes: [Date] = []
    @Binding var medications: [Medication]
    let units = ["Pills", "Tablets", "Drops", "ml","capsules", "sachet", "spray", "Injections"]
//    let trueIdxs = selectedDaysOfWeek.enumerate().flatmap{$1 ? $0 : nil }
//    var trueIndicesArray: [Int] = []
//    mutating func main() {
//
//        for (index, isSelected) in selectedDaysOfWeek.enumerated() {
//            if isSelected {
//                trueIndicesArray.append(index)
//            }
//        }
//        print("Indices of true elements: \(trueIndicesArray)")
//    }
    
    var body: some View {
        VStack {
            
            
            Section(header: Text("Summary")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.trailing, 12.0)){
                    Text("Name: \(medicationName)")
                        .multilineTextAlignment(.leading)
                Text("Unit: \(units[selectedUnitIndex])")
                    
            if selectedFrequencyIndex == 1 {
                Text("Frequency: Every \(numberOfDays) days")
            }
            else if selectedFrequencyIndex == 2 {
                Text("Frequency: Sunday, Monday, Wednesday, Saturday")
            }
            else{
                Text("Frequency: Every \(numberOfDays) days")
            }
            }
            Spacer()
            SwiftUI.Button(action: {
                let newMedication = Medication(
                    name: medicationName,
                    unit: selectedUnitIndex,
                    frequency: selectedFrequencyIndex
                    
//                    scheduleMode: medicationScheduleMode
                )
                medications.append(newMedication)
                medications=[]
            }) {
//                Text("Add More Medication")
//                    .padding()
            }
            Spacer()
            Button(
                action:{
                    
                },
                label:{
                    Text("Add More Medication")
                        .frame(width: 350,height: 75)
                        .fontWeight(.semibold)
                        .font(.headline)
                        .foregroundColor(.white)
                        
                }
                
            )
            .background(.blue)
            .cornerRadius(25)
        .navigationBarTitle("Medication Summary")
                }
    }
    

    // Helper method to format time as a string
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
struct TimePickerView: View {
    @Binding var selectedTime: Date
    var addRandomTime: (Date) -> Void

    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0

    var body: some View {
        VStack {
            Text("Select Time")
                .font(.headline)
                .padding()

            HStack {
                Text("Hour:")
                Picker("", selection: $selectedHour) {
                    ForEach(0..<24, id: \.self) { hour in
                        Text("\(hour)")
                    }
                }
                .labelsHidden()
                .frame(width: 50)

                Text("Minute:")
                Picker("", selection: $selectedMinute) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute)")
                    }
                }
                .labelsHidden()
                .frame(width: 50)
            }

            Button("Add Random Time") {
                // Create a new date with the selected hour and minute
                let calendar = Calendar.current
                var components = calendar.dateComponents([.year, .month, .day], from: selectedTime)
                components.hour = selectedHour
                components.minute = selectedMinute

                if let newRandomTime = calendar.date(from: components) {
                    // Call the closure to add the selected time
                    addRandomTime(newRandomTime)
                }
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
