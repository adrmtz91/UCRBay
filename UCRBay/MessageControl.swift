import SwiftUI

struct MessageControl: View {
    
    var imageUrl = URL(string: "https://unsplash.com/photos/a-blue-and-white-abstract-background-with-wavy-lines-EnUCKcXwrnY")
    var name = "jiale"
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width:50, height: 50)
                    .cornerRadius(50)
                
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        
        
    }
}

struct MessageControl_Previews: PreviewProvider {
    static var previews: some View {
        MessageControl()
            .background(Color("Blue"))
    }
}
