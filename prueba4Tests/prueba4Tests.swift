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
    
        //Prueba de caja negra, determina que los componentes estan bien colocados en su runtime.
        
        
        func testShowARView() throws {
            let app = XCUIApplication()
            app.launch()

            // Busca un botón con el icono "eye" para el primer platillo
            let eyeButton = app.buttons["eye"].firstMatch
            XCTAssertTrue(eyeButton.exists, "El botón 'eye' debería existir en la lista de platillos.")

            // Simula la acción de tocar el botón
            eyeButton.tap()

            // Verifica que la vista AR aparece
            let arView = app.otherElements["ARViewContainer"]
            XCTAssertTrue(arView.exists, "La vista AR debería mostrarse después de tocar el botón 'eye'.")
        }

       

        //Prueba caja blanca, para determinar la logica interna (calculos de funciones).
        
        func testEmptyCartTotal() {
            let emptyCartItems: [CartItem] = []
            let total = emptyCartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
            XCTAssertEqual(total, 0, "El total debería ser 0 para un carrito vacío.")
        }

        
    }
    
    
    //Prueba de aceptacion, permite verificar que los requisitos funcionales de la aplicacion se cumplan
    func testPlatilloMenuAndNavigation() throws {
        let app = XCUIApplication()
        app.launch()

        // Verifica que el primer platillo aparece en el menú
        let primerPlatillo = app.staticTexts["🍔 Hamburguesa (Combo)\n$100.00"]
        XCTAssertTrue(primerPlatillo.exists, "El primer platillo debería mostrarse en el menú.")

        // Verifica que el botón de carrito existe
        let cartButton = app.buttons["cart"]
        XCTAssertTrue(cartButton.exists, "El botón de carrito debería estar visible.")

        // Toca el botón de carrito y verifica que navega a la vista de compras
        cartButton.tap()
        let comprasView = app.staticTexts["Compras"] // Cambiar por un identificador válido de la vista Compras
        XCTAssertTrue(comprasView.exists, "Debería navegar a la vista 'Compras' después de tocar el botón del carrito.")
    }

    
    
   
    
    
       
    
    
    
}
