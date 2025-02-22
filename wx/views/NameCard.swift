import SwiftUI

struct NameCard: View {
    let name: String
    let wechatId: String

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 16) {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                        
                        Text("Weixin ID: \(wechatId)")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    // Optional "..." button on the right (if you want it)
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondary)
                        .padding(.trailing, 8)
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 12)
            }
            .background(Color.white)
            
            // Divider
            Divider()
            
            // Main List Section
            List {
                Section {
                    NavigationLink(destination: Text("Friend Profile View")) {
                        Text("Friend Profile")
                    }
                    
                    NavigationLink(destination: Text("Privacy Settings View")) {
                        Text("Privacy")
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Handle Messages action
                        }) {
                            HStack {
                                Image(systemName: "message")
                                Text("Messages")
                            }
                            .font(.system(size: 16))
                            .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                    .padding(10)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            // Handle Voice or Video Call action
                        }) {
                            HStack {
                                Image(systemName: "video")
                                Text("Voice or Video Call")
                            }
                            .font(.system(size: 16))
                            .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                    .padding(10)
                }
            }
            
        }
    }
}

#Preview {
    NameCard(name: "Trump", wechatId: "abc")
}

