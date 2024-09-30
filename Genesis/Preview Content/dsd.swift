
//

import SwiftUI
import Foundation

// Address model conforming to Codable for easy JSON parsing

enum AddressType : Int , CaseIterable {
    case home1 = 1
    case home2 = 3
    case work = 4
    
    var title : String {
        switch self {
        case .home1:
            "Home1"
        case .home2:
            "Home2"
        case .work:
            "Work"
        }
    }
}


struct Address: Codable {
    let add_area: Int
    let add_detail: String
    let add_latitude: String
    let add_longitude: String
    let add_name: String
    let add_street_name: String
    let add_type: Int
    let address_id: String
    let apartment_no: String
    let building_name: String
    let floor_no: String
    let user_id: String
    
    // Coding keys for mapping JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case add_area = "add_area"
        case add_detail = "add_detail"
        case add_latitude = "add_latitude"
        case add_longitude = "add_longitude"
        case add_name = "add_name"
        case add_street_name = "add_street_name"
        case add_type = "add_type"
        case address_id = "address_id"
        case apartment_no = "apartment_no"
        case building_name = "building_name"
        case floor_no = "floor_no"
        case user_id = "user_id"
    }
}


class EditAddressViewModel: ObservableObject {
    
    let jsonData = """
    {
      "add_area": 25059,
      "add_detail": "5, Apartment No: 3, Floor No: 2, Address Type: Home2",
      "add_latitude": "24.7135517",
      "add_longitude": "46.6752957",
      "add_name": "Home2 Address",
      "add_street_name": "",
      "add_type": 3,
      "address_id": "2669",
      "apartment_no": "3",
      "building_name": "5",
      "floor_no": "2",
      "user_id": "1"
    }
    """.data(using: .utf8)!
    
    
    @Published  var selectedLabel: AddressType = .home1
    @Published  var currentAddress: String = ""
    @Published  var buildingName: String = ""
    @Published  var floorNumber: String = ""
    @Published  var apartmentNumber: String = ""
    
    
    init() {
        setUI()
    }
    
    func setUI() {
        let address = getAddress()
        currentAddress = address?.add_detail ?? ""
        
        selectedLabel = AddressType(rawValue: (address?.add_type ?? 1)) ?? .home1
        
    }

    func getAddress() -> Address? {
        
        do {
            let address = try JSONDecoder().decode(Address.self, from: jsonData)
            return address
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        return nil
    }

}

struct EditAddressView: View {
    
    @ObservedObject var viewModel : EditAddressViewModel
    
    @State var isSpinning = false
    
    init(viewModel: EditAddressViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Navigation bar title and back button
            HStack {
                Button(action: {
                    // Back action
                }) {
                    Image(systemName: "arrow.left")
                        .bold()
                        .rotationEffect(.degrees(isSpinning ? -90 : 0))  // Rotating 90 degrees when tapped
                                        .animation(.easeInOut(duration: 0.3), value: isSpinning)  // Smooth animation
                        .foregroundColor(.white)
                        .padding(.vertical)
                        
                }
                Spacer()
                Text("Edit Address")
                    .font(Font.custom("Lato", size: 18))
                    .foregroundColor(.white)
               
                Spacer()
            }
            .padding(.horizontal)
            
            // District input field
            CustomTextField(placeholder: "Current Address", text: $viewModel.currentAddress)
            
            // Building name input field
            CustomTextField(placeholder: "Building Name", text: $viewModel.buildingName)
            
            // Floor number input field
            CustomTextField(placeholder: "Floor Number", text: $viewModel.floorNumber)
            
            // Apartment number input field
            CustomTextField(placeholder: "Apartment Number", text: $viewModel.apartmentNumber)
            
            
            // Address label selection
            VStack(alignment: .leading) {
                Text("Address Label")
                    .foregroundColor(.white)
                    .padding(.leading)
                
                HStack {
                    
                    ForEach(AddressType.allCases , id: \.rawValue) { item in
                        SelectableBox(addressType: item, selectedLabel: $viewModel.selectedLabel)
                        Spacer()
                        
                    }
                    
                }
                
            }
            .padding(.vertical)
            
            // Save button
            Button(action: {
                // Save action
                isSpinning.toggle()
            }) {
                Text("Save")
                  .font(
                    Font.custom("Lato", size: 18)
                      .weight(.bold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(red: 0.11, green: 0.28, blue: 0.55).edgesIgnoringSafeArea(.all))
    }
}

// Custom selectable box view for Address Label
struct SelectableBox: View {
    let addressType: AddressType
    @Binding var selectedLabel: AddressType
    
    var body: some View {
        Button(action: {
            selectedLabel = addressType
        }) {
            HStack {
                Image(systemName: addressType == selectedLabel ? "checkmark.square.fill" : "square")
                Text(addressType.title)
            }
            .foregroundColor(.white)
            .padding()
            
        }
    }
}

// Custom text field style
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder)
              .font(Font.custom("Lexend", size: 18))
              .foregroundColor(.white)
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                
        }
        .padding(.horizontal)
    }
}


#Preview {
    EditAddressView(viewModel: EditAddressViewModel())
}
