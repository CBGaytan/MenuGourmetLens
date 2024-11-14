//
//  Iniciar.swift
//  prueba4
//
//  Created by Cristian Gaytan on 12/11/24.
//

import SwiftUI

struct Iniciar: View {
    
    @State private var showARMenu = false // Controla si se muestra el menú AR
    @State private var showARMenu2 = false 
    @State private var email = "" // Campo de correo electrónico
    @State private var password = "" 
    var body: some View {
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
            HStack{   // Botón para registrarse
                Button(action: {
                    // Acción para registrarse, puedes agregar validaciones aquí
                  
                    showARMenu = true // Muestra el menú AR
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

