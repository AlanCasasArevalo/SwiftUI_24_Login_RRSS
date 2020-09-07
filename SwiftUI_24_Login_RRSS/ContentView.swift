import SwiftUI
import FBSDKLoginKit
import Firebase

struct ContentView: View {
    @State private var show = false
    
    var body: some View {
        VStack {
            LoginFacebook(show: $show)
                .frame(width: 200, height: 50, alignment: .center)
            LoginGoogle(show: $show)
                .frame(width: 200, height: 50, alignment: .center)
            if show {
                Text("Usuario logeado")
            } else {
                Text("Usuario NO logeado")
            }
            
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    self.show = false
                } catch let error {
                    print(error.localizedDescription)
                }
            }) {
                Text("Salir de google")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


