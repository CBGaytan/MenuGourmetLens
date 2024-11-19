import SwiftUI
import CoreData

struct Registrate: View {
    @State private var showARMenu = false
    @State private var showARMenu2 = false
    @State private var showErrorAlert = false
    @State private var email = ""
    @State private var password = ""
    @State private var address = ""
    @State private var phoneNumber = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Image("ca")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
                    .foregroundColor(.red)
                
                Text("Bienvenido(a)")
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .italic()
                    .foregroundColor(.red)
                    .padding()
                
                TextField("Nombre(s)", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Apellido(s)", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Dirección", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Número de teléfono", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .padding()
                
                HStack {
                    Button(action: {
                        saveUser() // Guardar los datos en Core Data
                        clearFields() // Limpiar los campos después de guardar
                        
                    }) {
                        Text("Guardar")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    
                    
                    Button(action: {
                        showARMenu2 = true
                    }) {
                        Text("Conectarse")
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.red)
                            .cornerRadius(30)
                    }
                    .fullScreenCover(isPresented: $showARMenu2) {
                        Iniciar()
                    }
                    .alert(isPresented: $showErrorAlert) {
                        Alert(
                            title: Text("Resultado"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("Aceptar"))
                        )
                    }
                }
                .padding()
            }
        }
    }
    
    // Función para guardar datos en Core Data
    private func saveUser() {
        let context = CoreDataManager.shared.context
           
        // Crear un nuevo objeto 'User'
        let newUser = User(context: context)
        
        // Asignar valores a los atributos de 'User'
        newUser.nombres = firstName
        newUser.apellidos = lastName
        newUser.correo = email
        newUser.contra = password
        newUser.direccion = address
        newUser.telefono = phoneNumber
        
        // Guardar el contexto
        do {
            try context.save()
            alertMessage = "Usuario guardado con éxito"
            showErrorAlert = true // Mostrar el alert con éxito
        } catch {
            alertMessage = "Error al guardar usuario: \(error)"
            showErrorAlert = true // Mostrar el alert con error
        }
    }

    // Función para limpiar los campos de texto
    private func clearFields() {
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        address = ""
        phoneNumber = ""
    }
}

