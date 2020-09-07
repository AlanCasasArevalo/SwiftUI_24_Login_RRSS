import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    @State private var show = false
    
    var body: some View {
        VStack {
            LoginFacebook(show: $show)
                .frame(width: 200, height: 50, alignment: .center)
            if show {
                Text("Usuario logeado")
            } else {
                Text("Usuario NO logeado")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


