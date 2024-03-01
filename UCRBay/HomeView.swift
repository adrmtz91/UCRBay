//  HomeView.swift
//  UCRBay
//
import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("Welcome to UCRBay, \(userViewModel.username)!")
                .font(.title)
                .padding()
            
            // Place holder for content not yet functional
            ScrollView {
                VStack {
                    ForEach(0..<10) { item in
                        Text("Item \(item)")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(4)
                    }
                }
            }
            
            Button("Log Out") {
                userViewModel.logout()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserViewModel())
    }
}
