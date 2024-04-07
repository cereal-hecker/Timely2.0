//
//  EditView.swift
//  Timely2.0
//
//  Created by user2 on 04/04/24.
//
import SwiftUI
import Combine
import PhotosUI
import Firebase
import FirebaseAuth
import FirebaseStorage


final class EditProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var emailChange: String = ""
    @Published var passwordChange: String = ""
    @Published var confirmpasswordChange: String = ""
    private var cancellables = Set<AnyCancellable>()
    init() {
        setupUser()
    }
    
    private func setupUser(){
        UserManager.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in viewModel from Profile is \(String(describing: user))")
        }.store(in: &cancellables)
    }
    
//    func updateEmail() async throws {
//        
//          try await  AuthenticationManager.shared.updateEmail(newEmail: emailChange)
//    }
    
    func updatePassword() async throws {
        do {
            try await AuthenticationManager.shared.updatePassword(password: passwordChange)
        } catch let error as NSError {
            print("updatepassword")
            throw error
        }
    }
    func updateEmail() async throws {
        do {
            try await AuthenticationManager.shared.updateEmail(email: emailChange)
            // Password reset email sent successfully
        } catch let error as NSError {
            print("updaerror")
            // Handle errors
            throw error
        }
    }
    func resetPassword() async throws {
        do {
            try await AuthenticationManager.shared.resetPassword(email: currentUser?.email ?? "")
            // Password reset email sent successfully
        } catch let error as NSError {
            // Handle errors
            throw error
        }
    }
    
}


struct EditProfileView: View {
    @StateObject private var viewModel = EditProfileViewModel()
    
    @State private var profileImage: UIImage?
    @State private var isShowingImagePicker = false
    
    @State private var isChangeProfileImage = false
    @State private var isChangeUserName = false
    @State private var isChangeEmail = false
    @State private var isChangePassword = false
    
    
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    List {
                        Section{
                            HStack(alignment: .center) {
                                if profileImage != nil {
                                    Image(uiImage: profileImage ?? UIImage(systemName: "person.circle")!)
                                        .resizable()
                                        .frame(width: 72, height: 72)
                                        .cornerRadius(72)
                                } else {
                                    Text(currentUser?.initials ?? "")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .frame(width: 72, height: 72)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment:.leading){
                                    Text(currentUser?.email ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                    Text(currentUser?.username ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                    
                                }
                                .padding(.leading, 30)
                            }
                            .padding(2)
                        }
                        .listRowBackground(Color.grey1)
                        
                        Section {
//                            if isChangeProfileImage {
                                Button(action: {
                                    isShowingImagePicker.toggle()
                                    isChangeProfileImage.toggle()
                                }) {
                                    Text("Change Profile Image")
                                        .padding()
                                        .background(Color.grey2)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .sheet(isPresented: $isShowingImagePicker) {
                                    ImagePicker(image: $profileImage, isPresented: $isShowingImagePicker)
                                }
                            if isChangeProfileImage {
                                Button {
                                    if let profileImage = profileImage {
                                        
                                        UserManager.shared.uploadProfileImage(image: profileImage)
                                        isChangeProfileImage.toggle()
                                    }
                                    
                                    
                                } label: {
                                    Text("Save")
                                }
                            }
                        }
                        .foregroundStyle(Color.white)
                        .listRowBackground(Color.grey1)
                        
//                        Section {
//                            if !isChangeEmail {
//                                Button(action: {
//                                    isChangeEmail.toggle()
//                                }) {
//                                    Text("Edit Email")
//                                }
//                            } else {
//                                Text("Current: \(currentUser?.email ?? "")")
//                                    .foregroundColor(.white)
//                                
//                                TextField("Enter new email", text: $viewModel.emailChange)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                    .padding()
//                                
//                                Button(action: {
//                                    isChangeEmail.toggle()
//                                    Task{
//                                       try await viewModel.updateEmail()
//                                    }
//                                }) {
//                                    Text("SAVE")
//                                        .padding()
//                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
//                                        .foregroundColor(.white)
//                                }
//                                .padding(.bottom, 40)
//                                .offset(x: 50)
//                            }
//                        }
//                        .foregroundStyle(Color.white)
//                        .listRowBackground(Color.grey1)
                        
                        Section {
                            if !isChangePassword {
                                Button(action: {
                                    isChangePassword.toggle()
                                }) {
                                    Text("Edit Password")
                                }
                            } else {
                                TextField("Enter new password", text: $viewModel.passwordChange)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                
                                ZStack{
                                    SecureField("Confirm new password", text: $viewModel.confirmpasswordChange)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                                    
                                    if !viewModel.passwordChange.isEmpty && !viewModel.confirmpasswordChange.isEmpty {
                                        if viewModel.passwordChange == viewModel.confirmpasswordChange {
                                            Image(systemName: "checkmark.circle.fill")
                                                .imageScale(.large)
                                                .foregroundColor(.green)
                                                .offset(x:-8,y:-12)
                                        } else {
                                            Image(systemName: "xmark.circle.fill")
                                                .imageScale(.large)
                                                .foregroundColor(.red)
                                                .offset(x:-8,y:-12)
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    isChangePassword.toggle()
                                    Task{
                                        try await viewModel.updatePassword()
                                    }
                                }) {
                                    Text("Confirm to change Password")
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                                        .foregroundColor(.white)
                                }
                                .padding(.bottom, 40)
                                .offset(x: 50)
                            }
                        }
                        .foregroundStyle(Color.white)
                        .listRowBackground(Color.grey1)
                        

                    }
                }
                .scrollContentBackground(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .onAppear {
                fetchProfileImage()
        }
        }
    }
    
    // MARK: Fetch Profile Image
    private func fetchProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not authenticated.")
            return
        }
        print("fetch was called")
        
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("profileImage/\(uid).jpg")
        
        // Fetch image data from Firebase Storage
        profileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching profile image: \(error.localizedDescription)")
            } else {
                
                if let data = data, let image = UIImage(data: data) {
                    print(image)
                    self.profileImage = image
                }
            }
        }
    }

}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.isPresented = false
            if let itemProvider = results.first?.itemProvider,
               itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self?.parent.image = image
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EditProfileView()
}
