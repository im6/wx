import SwiftUI

@MainActor
class PostViewModel: ObservableObject {
    @Published var postList : [Post] = []
    @Published var isLoading : Bool = true
    private var fetchTask: Task<Void, Never>?
    
    init() {
        fetchTask = Task {
            await loadData()
        }
    }
    
    func removeOnePost (at offsets: IndexSet) {
        postList.remove(atOffsets: offsets)
    }

    func loadData() async {
        // Cancel any ongoing fetch task before starting a new one
        fetchTask?.cancel()

        fetchTask = Task {
            // isLoading = true
            do {
                let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let posts = try JSONDecoder().decode([Post].self, from: data)

                try await Task.sleep(nanoseconds: 3_000_000_000) // Simulating delay

                // Check if the task was canceled before updating the UI
                guard !Task.isCancelled else { return }

                postList = posts
            } catch let error as NSError {
                if error.code != -999 { // Ignore cancellation errors
                    print("Failed to load posts:", error)
                }
            }
            isLoading = false
        }

        await fetchTask?.value
    }
}


struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
