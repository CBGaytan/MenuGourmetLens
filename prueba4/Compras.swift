//
//  Compras.swift
//  prueba4
//
//  Created by Cristian Gaytan on 12/11/24.
//

import SwiftUI

struct Compras: View {
    // Datos de ejemplo para la dirección y los productos en el carrito
    @State private var address = "123 Calle Ficticia, Ciudad, País"
    @State private var phoneNumber = "123-456-7890"
    @State private var showARMenu2 = false
    
    // Lista de productos en el carrito
    @State private var cartItems = [
        CartItem(name: "Helado", quantity: 2, price: 199.99),
        CartItem(name: "Pizza combo", quantity: 1, price: 99.99),
        CartItem(name: "Refresco", quantity: 3, price: 49.99)
    ]
    
    // Calcular el total
    var total: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Título de la vista
            Text("Carrito de Compras")
                .font(.largeTitle)
                .padding()
            
            // Mostrar la dirección de envío
            VStack(alignment: .leading, spacing: 10) {
                Text("Dirección de envío:")
                    .font(.headline)
                Text(address)
                    .font(.body)
                    .padding(.bottom)
                
                Text("Número de teléfono:")
                    .font(.headline)
                Text(phoneNumber)
                    .font(.body)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Lista de productos en el carrito
            VStack(alignment: .leading, spacing: 10) {
                Text("Productos en el carrito:")
                    .font(.headline)
                
                ForEach(cartItems, id: \.name) { item in
                    HStack {
                        Text("\(item.name) x\(item.quantity)")
                            .font(.body)
                        Spacer()
                        Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                            .font(.body)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Mostrar el total
            HStack {
                Text("Total:")
                    .font(.headline)
                Spacer()
                Text("$\(String(format: "%.2f", total))")
                    .font(.headline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Botón de compra
            
                
            HStack(spacing: 20) {  // Espaciado entre los botones
                // Botón para ir al menú AR (Iniciar sesión)
                Button(action: {
                    showARMenu2 = true
                }) {
                    Image(systemName: "house")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .frame(width: 70, height: 50)
                }
                .fullScreenCover(isPresented: $showARMenu2) {
                    // Llamada a la vista Iniciar cuando se presione el botón
                    ContentView()
                }
                
                // Botón para registrarse
                Button(action: {
                    showARMenu2 = true
                }) {
                    Text("Comprar")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .frame(width: 200, height: 50)
                }
                .fullScreenCover(isPresented: $showARMenu2) {
                    // Llamada a la vista Registrate cuando se presione el botón
                    ContentView()
                }
            }
            .padding(.horizontal, 20) // Espacio lateral para que los botones no toquen los bordes
                
            }
            }
                
                
            
}

struct CartItem {
    var name: String
    var quantity: Int
    var price: Double
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        Compras()
    }
}

