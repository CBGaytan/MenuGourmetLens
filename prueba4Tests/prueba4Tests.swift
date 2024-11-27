//
//  prueba4Tests.swift
//  prueba4Tests
//
//  Created by Cristian Gaytan on 21/10/24.
//

import Testing
import XCTest
@testable import prueba4

struct prueba4Tests {
    
    //Prueba unitaria para determinar los calculos del carrito
    
    final class ComprasTests: XCTestCase {
        func testTotalCalculation() {
            // Datos de ejemplo
            let cartItems = [
                CartItem(name: "Helado", quantity: 2, price: 199.99),
                CartItem(name: "Pizza combo", quantity: 1, price: 99.99),
                CartItem(name: "Refresco", quantity: 3, price: 49.99)
            ]
            
            // Cálculo esperado
            let expectedTotal = 2 * 199.99 + 1 * 99.99 + 3 * 49.99
            
            // Probar cálculo real
            let calculatedTotal = cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
            
            XCTAssertEqual(expectedTotal, calculatedTotal, accuracy: 0.01, "El total calculado no es correcto.")
        }
       
        //Prueba de estres, para determinar que la vista funcione correctamente con grandes volumenes de datos
        func testLargeCartPerformance() {
            // Crear una lista grande de productos
            let largeCartItems = (1...1000).map { CartItem(name: "Producto \($0)", quantity: Int.random(in: 1...10), price: Double.random(in: 1.0...100.0)) }
            
            // Medir el rendimiento
            measure {
                let total = largeCartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
                XCTAssert(total > 0, "El total debe ser mayor a 0.")
            }
        }
    
        
        //Prueba de caja negra, para determinar una buena funcionalidad de los componentes sin tener encuenta el codigo interno
        
        func testButtonNavigation() {
            let app = XCUIApplication()
            app.launch()

            let comprarButton = app.buttons["Comprar"]
            XCTAssertTrue(comprarButton.exists, "El botón 'Comprar' debería existir.")
            comprarButton.tap()

            XCTAssertTrue(app.otherElements["ContentView"].exists, "Debería navegar a la vista 'ContentView'.")
        }

        //Prueba caja blanca, para determinar la logica interna (calculos de funciones).
        
        func testEmptyCartTotal() {
            let emptyCartItems: [CartItem] = []
            let total = emptyCartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
            XCTAssertEqual(total, 0, "El total debería ser 0 para un carrito vacío.")
        }

        //Prueba de aceptacion, para determinar si la app cumple los requisitos funcionales
        func testCartDisplay() {
            let app = XCUIApplication()
            app.launch()
            
            let heladoText = app.staticTexts["Helado x2"]
            XCTAssertTrue(heladoText.exists, "El producto 'Helado' debería mostrarse en el carrito.")

            let totalText = app.staticTexts["Total: $"]
            XCTAssertTrue(totalText.exists, "El total debería mostrarse en la vista.")
        }

        
        
        
    }
    
    
   
    
    
       
    
    
    
}
