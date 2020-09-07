
import SwiftUI
import GoogleSignIn
import Firebase

struct LoginGoogle: UIViewRepresentable {
    
    @Binding var show: Bool
    
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        
        GIDSignIn.sharedInstance()?.delegate = context.coordinator
        
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return LoginGoogle.Coordinator(connection: self)
    }
    
    class Coordinator: NSObject, GIDSignInDelegate {
        
        var connection: LoginGoogle
        
        init(connection: LoginGoogle) {
            self.connection = connection
        }
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if error != nil {
                print(error.localizedDescription)
                return
            }
            
            guard let userAuthentication = user.authentication else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: userAuthentication.idToken, accessToken: userAuthentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (result, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                self.connection.show = true
                
                print("user: \(result?.user)")
            }
        }
        
    }
}



