
import SwiftUI
import FBSDKLoginKit
import Firebase

struct LoginFacebook: UIViewRepresentable {
    
    @Binding var show: Bool
    
    func makeUIView(context: Context) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        button.delegate = context.coordinator
        
        return button
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return LoginFacebook.Coordinator(connection: self)
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        
        var connection: LoginFacebook
        
        init(connection: LoginFacebook) {
            self.connection = connection
        }
                
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            if AccessToken.current != nil {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
                Auth.auth().signIn(with: credential) { (result, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    print("Usuario logeadooooooooooo")
                    self.connection.show = true
                    print(Auth.auth().currentUser?.email)
                    
                }
            }
            
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            do {
                try Auth.auth().signOut()
                self.connection.show = false
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

