//
//  WelcomeView.swift
//  prueba4
//
//  Created by Cristian Gaytan on 12/11/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showIniciar = false // Controla si se muestra el menú AR
    @State private var showRegister = false
    var body: some View {
        VStack(spacing: 20) {
            
            Image("ca") // Usa el nombre de tu imagen aquí
                .resizable()
                .frame(width: 300, height: 300)
                .padding()
                .foregroundColor(.red)
            
            Text("Bienvenido(a)")
                .font(.system(size: 24, weight: .regular, design: .rounded)) // Cambiar el tamaño de la fuente
                .italic() // Cursiva
                .foregroundColor(.red) // Color rojo
                .padding()
            
            
            VStack(spacing: 20) {  // Espaciado entre los botones
                // Botón para ir al menú AR (Iniciar sesión)
                Button(action: {
                    showIniciar = true
                }) {
                    Text("Iniciar sesion")
                        .font(.system(size: 24, weight: .regular, design: .rounded)) // Cambiar el tamaño de la fuente
                        .italic() // Cursiva
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .frame(width: 200, height: 50)
                }
                .fullScreenCover(isPresented: $showIniciar) {
                    // Llamada a la vista Iniciar cuando se presione el botón
                    Iniciar()
                }
                
                // Botón para registrarse
                Button(action: {
                    showRegister = true
                }) {
                    Text("Crear Cuenta")
                        .font(.system(size: 24, weight: .regular, design: .rounded)) // Cambiar el tamaño de la fuente
                        .italic() // Cursiva
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .frame(width: 200, height: 50)
                        
                }
                .fullScreenCover(isPresented: $showRegister) {
                    // Llamada a la vista Registrate cuando se presione el botón
                    Registrate()
                       
                                            
                }
            }
            .padding(.horizontal, 20) // Espacio lateral para que los botones no toquen los bordes
            
        }
    }
}
