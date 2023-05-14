import SwiftUI

struct MessageViewModel: View {
    var message: VideoMessage
    
    var body: some View {
        VStack {
            Text("Sender: \(message.sender?.nickname ?? "")")
            Text("Receiver: \(message.receiver?.nickname ?? "")")
            Text("Created Date: \(formattedDate(message.createdDate))")
            // Display other properties as needed
            
            Spacer()
        }
        .padding()
        
    }
    
    
    // Helper method to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct MessageViewModel_Previews: PreviewProvider {
    static var previews: some View {
        let videoMessageViewModel = VideoMessageViewModel()
        
        return MessageViewModel(message: videoMessageViewModel.videoMessages.first!)
    }
}
