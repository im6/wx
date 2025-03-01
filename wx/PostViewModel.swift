import SwiftUI

@MainActor
class PostViewModel: ObservableObject {
    @Published var postList : [Post] = []
    @Published var isLoading : Bool = true
    
    init() {
        Task {
            await self.loadData()
        }
    }

    func loadData() async {
        isLoading = true
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let posts = try JSONDecoder().decode([Post].self, from: data)
            try await Task.sleep(nanoseconds: 3_000_000_000)
            postList = posts
        } catch {
            print("Failed to load posts:", error)
        }
        isLoading = false
    }
}


struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
