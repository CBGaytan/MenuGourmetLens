//
//  Registrarte.swift
//  prueba4
//
//  Created by Cristian Gaytan on 12/11/24.
//


import SwiftUI

struct Registrate: View {
    @State private var showARMenu = false
    @State private var showARMenu2 = false// Controla si se muestra el menú AR
    
    @State private var email = "" // Campo de correo electrónico
    @State private var password = "" // Campo de contraseña
    @State private var address = "" // Campo de dirección
    @State private var phoneNumber = "" // Campo de número de teléfono
    
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
                
                // Campo de texto para el nombre
                TextField("Nombre(s)", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Campo de texto para los apellidos
                TextField("Apellido(s)", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Campo de texto para el correo electrónico
                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Campo de texto para la contraseña
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Campo de texto para la dirección
                TextField("Dirección", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Campo de texto para el número de teléfono
                TextField("Número de teléfono", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad) // Para mostrar el teclado numérico
                    .padding()
                
                HStack{   // Botón para registrarse
                    Button(action: {
                        // Acción para registrarse, puedes agregar validaciones aquí
                        print("Correo: \(email), Contraseña: \(password), Dirección: \(address), Teléfono: \(phoneNumber)")
                        showARMenu = true // Muestra el menú AR
                    }) {
                        Text("Registrarte")
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
                    
                    // Botón para cancelar
                    Button(action: {
                        // Acción para cancelar, puedes agregar validaciones aquí
                        showARMenu2 = true // Muestra el menú AR
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
}
