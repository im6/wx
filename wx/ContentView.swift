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
    @ObservedObject var viewModel = PostViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.postList, id: \.id) { post in
                            VStack(alignment: .leading) {
                                Text(post.title)
                                    .font(.headline)
                                Text(post.body)
                                    .font(.subheadline)
                            }
                        }
                        .onDelete(perform: viewModel.removeOnePost)
                    }
                    .refreshable {
                        await viewModel.loadData()
                    }
                }
            }
        }
        .onAppear {
            Task {
                print("on Appear")
            }
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
