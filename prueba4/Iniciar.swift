//
//  Iniciar.swift
//  prueba4
//
//  Created by Cristian Gaytan on 12/11/24.
//

import SwiftUI
import CoreData

struct Iniciar: View {
    
    @State private var showARMenu = false // Controla si se muestra el menú AR
    @State private var showErrorAlert = false // Controla si se muestra el mensaje de error
    @State private var showARMenu2 = false
    @State private var email = "" // Campo de correo electrónico
    @State private var password = "" // Campo de contraseña
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Image("ca") // Usa el nombre de tu imagen aquí
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
                    .foregroundColor(.red)
                
                Text("Bienvenido(a)")
                    .font(.system(size: 24, weight: .regular, design: .rounded)) // Cambiar el tamaño de la fuente
                    .italic() // Cursiva
                    .foregroundColor(.red) // Color rojo
                    .padding()
                
                // Campo de texto para el correo electrónico
                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Campo de texto para la contraseña
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    // Botón para iniciar sesión
                    Button(action: {
                        if verificarUsuario(email: email, password: password) {
                            showARMenu = true // Usuario válido, muestra la siguiente vista
                        } else {
                            showErrorAlert = true // Usuario no válido, muestra error
                        }
                    }) {
                        Text("Conectarte")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .fullScreenCover(isPresented: $showARMenu) {
                        // Llamada a la vista cuando se presione el botón
                        ContentView()
                    }
                    .alert(isPresented: $showErrorAlert) {
                        Alert(title: Text("Error"),
                              message: Text("Correo o contraseña incorrectos."),
                              dismissButton: .default(Text("OK")))
                    }
                    
                    // Botón para cancelar
                    Button(action: {
                        // Acción para cancelar
                        showARMenu2 = true
                    }) {
                        Text("Cancelar")
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.red)
                            .cornerRadius(30)
                    }
                    .fullScreenCover(isPresented: $showARMenu2) {
                        // Llamada a la vista cuando se presione el botón
                        WelcomeView()
                    }
                    
                    
                }
                .padding()
            }
        }
    }
        
        // Función para verificar usuario en Core Data
        func verificarUsuario(email: String, password: String) -> Bool {
            let context = CoreDataManager.shared.context
            
            // Crear la solicitud de búsqueda con un filtro para correo y contraseña
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            
            // Crear un predicado que busque el correo y la contraseña
            fetchRequest.predicate = NSPredicate(format: "correo == %@ AND contra == %@", email, password)
            
            do {
                // Ejecutar la búsqueda
                let users = try context.fetch(fetchRequest)
                
                // Verificar si se encontró algún usuario
                if users.count > 0 {
                    print("Usuario encontrado")
                    return true // El usuario existe
                } else {
                    print("Usuario no encontrado")
                    return false // El usuario no existe
                }
            } catch {
                print("Error al verificar el usuario: \(error)")
                return false
            }
        }
    
}

