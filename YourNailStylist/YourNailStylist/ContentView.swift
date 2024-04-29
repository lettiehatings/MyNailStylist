//
//  ContentView.swift
//  YourNailStylist
//
//  Created by Hastings, Lettie on 4/15/24.
//
import SwiftUI

struct NailColor {
    var name: String
    var color: Color
    var salonNames: [String]
}

struct ContentView: View {
    @State private var nailStyle: String = "Round"
    @State private var selectedColorIndex = 0
    @State private var shadeValue: Double = 0.5
    @State private var showInstructions = true
    @State private var showSalonNames = false
    
    let nailColors: [NailColor] = [
        NailColor(name: "Red", color: .red, salonNames: ["Cherry Bomb", "Fire Engine", "Scarlet Fever"]),
        NailColor(name: "Blue", color: .blue, salonNames: ["Sky High", "Ocean Blue", "Sapphire Dream"]),
        NailColor(name: "Green", color: .green, salonNames: ["Emerald Isle", "Forest Green", "Minty Fresh"]),
        NailColor(name: "Yellow", color: .yellow, salonNames: ["Lemon Zest", "Sunshine Glow", "Goldenrod"]),
        NailColor(name: "Pink", color: .pink, salonNames: ["Bubblegum Bliss", "Cotton Candy", "Pink Paradise"]),
        NailColor(name: "Purple", color: .purple, salonNames: ["Royal Majesty", "Lavender Love", "Plum Perfection"])
    ]
    
    var selectedColorNames: [String] {
        return nailColors[selectedColorIndex].salonNames
    }
    
    var body: some View {
        VStack {
            if showInstructions {
                Text("Welcome to the Nail Color Picker app!")
                    .font(.title)
                    .padding()
                
                Text("This app allows you to explore and select your next nail color and style. Follow these simple steps:")
                    .padding(.leading, 0)
                
                Text("1. Choose your preferred nail style (Round, Square, or Oval) using the segmented picker.")
                    .frame(maxWidth: .infinity, alignment: .leading) // left align
                   
                
                Text("2. Select your desired nail color from the color wheel picker.")
                    .frame(maxWidth: .infinity, alignment: .leading) // left align
                   
                
                Text("3. Adjust the color shade using the slider labeled 'Color Shade'. Move the slider to the left for lighter shades and to the right for darker shades.")
                    .frame(maxWidth: .infinity, alignment: .leading) // left align
                   
                
                Text("4. Once satisfied with your selection, admire your chosen nail color displayed in the circle below.")
                    .frame(maxWidth: .infinity, alignment: .leading) // left align
                
                Text("5. Feel free to experiment with different combinations until you find the perfect nail color and style for your next manicure!")
                    .frame(maxWidth: .infinity, alignment: .leading) // left align
                
                Button(action: {
                    self.showInstructions = false
                }) {
                    Text("Got it!")
                }
                .padding()
            } else {
                Spacer()
                
                Circle()
                    .foregroundColor(nailColors[selectedColorIndex].color.opacity(shadeValue))
                    .frame(width: 100, height: 100)
                    .padding()
                
                Picker("Nail Style", selection: $nailStyle) {
                    Text("Round").tag("Round")
                    Text("Square").tag("Square")
                    Text("Oval").tag("Oval")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Picker("Nail Color", selection: $selectedColorIndex) {
                    ForEach(0..<nailColors.count) { index in
                        Text(self.nailColors[index].name)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                
                Slider(value: $shadeValue, in: 0...1) {
                    Text("Color Shade")
                }
                .padding()
                
                if showSalonNames {
                    Text("Recommended Names in Salons:")
                        .padding()
                    
                    ForEach(selectedColorNames, id: \.self) { name in
                        Text(name)
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    self.showInstructions = true
                    self.showSalonNames = false
                    self.selectedColorIndex = 0
                    self.shadeValue = 0.5
                }) {
                    Text("Reset")
                }
                .padding()
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            self.showSalonNames = false
        }
        .onChange(of: selectedColorIndex) { _ in
            self.showSalonNames = false
        }
        .onChange(of: shadeValue) { _ in
            self.showSalonNames = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
