import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ChatsView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Chats")
                }

            Contacts()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Contacts")
                }

            DiscoverView()
                .tabItem {
                    Image(systemName: "safari")
                    Text("Discover")
                }

            MeView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Me")
                }
        }.accentColor(.green)
    }
}

// Placeholder Views
struct ChatsView: View {
    var body: some View {
        NavigationView {
            Text("Chats View 1")
                .navigationTitle("Chats")
        }
    }
}

struct ContactsView: View {
    var body: some View {
        NavigationView {
            Text("Contacts View")
                .navigationTitle("Contacts")
        }
    }
}

struct DiscoverView: View {
    var body: some View {
        NavigationView {
            Text("Discover View")
                .navigationTitle("Discover")
        }
    }
}

struct MeView: View {
    var body: some View {
        NavigationView {
            Text("Me View")
                .navigationTitle("Me")
        }
    }
}

#Preview {
    ContentView()
}
