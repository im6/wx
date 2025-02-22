import SwiftUI

struct Contacts: View {
    let contacts = [
        "A": ["Alice Anderson", "Aaron Axton"],
        "B": ["Ben Brown", "Bella Bates"],
        "C": ["Charlie Carter", "Cindy Chen"],
        "D": ["David Dawson", "Diana Doe"],
        "E": ["Ethan Evans", "Emma Ellis"]
    ]

    @State private var searchText = ""

    var filteredContacts: [String: [String]] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.mapValues { names in
                names.filter { $0.lowercased().contains(searchText.lowercased()) }
            }.filter { !$0.value.isEmpty }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                // Search Bar
                if #available(iOS 15.0, *) {
                    Section {
                        TextField("Search Contacts", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                    }
                }

                // Contacts List
                ForEach(filteredContacts.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(filteredContacts[key]!, id: \.self) { contact in
                            NavigationLink(value: contact) {
                                ContactRow(name: contact)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { contact in
                NameCard(name: contact, wechatId: contact)
            }
            .navigationTitle("Contacts")
        }
    }
}

struct ContactRow: View {
    let name: String

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            Text(name)
                .font(.system(size: 18))
            Spacer()
        }
        .padding(.vertical, 5)
    }
}


#Preview {
    Contacts()
}
