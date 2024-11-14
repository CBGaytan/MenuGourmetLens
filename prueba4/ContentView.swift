import SwiftUI
import RealityKit
import ARKit
import Combine

struct ContentView: View {
    @State private var showARView = false
    @State private var showARView2 = false// Controla si se muestra la vista AR
    @State private var selectedModel: String? // Almacena el modelo seleccionado
    @State private var showIniciar = false
    
    let modelNames = [
        "Nuevo proyecto 15",
        "Nuevo proyecto 4-2",
        "Nuevo proyecto 16-2",
        "Nuevo proyecto 6-3",
        "Nuevo proyecto 5-2",
        "Nuevo proyecto 7-2",
        "Nuevo proyecto 10",
        "Nuevo proyecto 11",
        "Nuevo proyecto 12",
        "Nuevo proyecto 13",
        "Nuevo proyecto 14",
    ]
    
    
    let modelNames2 = [
        "🍔 Hamburguesa \n      $100 (Combo)",
        "🍔 Hamburguesa \n      $80",
        "🍕🥤 Combo Pizza\n      $230 (Combo)       ",
        "🍕 Pizza familiar\n      $99    ",
        "🌮 Tacos \n      $85",
        "🍲 Comida china\n      $95      ",
        "🍰 Pastel\n      $200              ",
        "🍟 Papas fritas\n      $60        ",
        "🧆 Platillo del dia\n      $76   ",
        "🍨 Helado\n      $29",
        "☕️ Cafe\n      $30"
        
    ]
    var body: some View {
        Group {
            if showARView {
                // Mostrar la vista AR con el modelo seleccionado
                ARViewContainer(selectedModel: selectedModel ?? "", showARView: $showARView)
                    .edgesIgnoringSafeArea(.all)
            } else {
                // Vista inicial con los  botones y scroll
                VStack {
                    
                    Image("ca") // Usa el nombre de tu imagen aquí
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                        .foregroundColor(.red)
                    
                    HStack {
                        // Texto "Menu" alineado a la izquierda
                        Text("Menu______")
                            .font(.largeTitle)
                            .padding()
                        
                        Spacer()  // Esto empuja el siguiente elemento (el botón) hacia la derecha
                        
                        // Botón con el icono de carrito alineado a la derecha
                        Button(action: {
                            showIniciar = true
                        }) {
                            Image(systemName: "cart") // Icono de carrito
                                .font(.title)
                                .padding()
                                .frame(width: 50, height: 50) // Ancho y altura para el botón
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        .fullScreenCover(isPresented: $showIniciar) {
                            // Llamada a la vista Compras cuando se presione el botón
                            Compras()
                        }
                    }
                    .padding(.horizontal, 20) // Espacio lateral
                    .frame(maxWidth: .infinity, alignment: .leading) // Alineación del HStack a la izquierda


                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(0..<modelNames.count, id: \.self) { index in
                                HStack {
                                    // Texto a la izquierda del botón
                                    Text(modelNames2[index]) // Muestra el nombre del modelo
                                        .font(.title2)
                                        .padding(.trailing, 10) // Espacio entre el texto y el botón
                                    
                                    Spacer()
                                    
                                    // Botón para mostrar el modelo en AR
                                    Button(action: {
                                        selectedModel = modelNames[index] // Modelo seleccionado
                                        showARView = true
                                    }) {
                                        Image(systemName: "eye") // Icono de ojo
                                            .font(.title)
                                            .padding()
                                            .frame(width: 50) // Ancho fijo para el botón
                                            .background(Color.white)
                                            .foregroundColor(.red)
                                            .cornerRadius(10)
                                    }
                                    
                                    // Botón para mostrar la vista de precios
                                    Button(action: {
                                        showARView2 = true
                                    }) {
                                        Image(systemName: "dollarsign.circle") // Icono de signo de pesos
                                            .font(.title)
                                            .padding()
                                            .frame(width: 50) // Ancho fijo para el botón
                                            .background(Color.white)
                                            .foregroundColor(.green)
                                            .cornerRadius(10)
                                    }
                                    .fullScreenCover(isPresented: $showARView2) {
                                        Compras() // Reemplaza con tu vista personalizada
                                    }
                                }
                                .padding(.horizontal, 20) // Espacio lateral
                                .frame(maxWidth: .infinity, alignment: .leading) // Alinear el HStack a la izquierda
                            }
                        }

                        }
                    }
                }
            }
        }
    }
    
    struct ARViewContainer: UIViewRepresentable {
        let selectedModel: String // Modelo seleccionado
        @Binding var showARView: Bool // Binding para controlar la vista AR
        
        func makeUIView(context: Context) -> ARView {
            let arView = ARView(frame: .zero)
            
            // Configuración del AR
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = [.horizontal]
            arView.session.run(configuration)
            
            // Botón para regresar
            let backButton = UIButton(frame: CGRect(x: 20, y: 40, width: 100, height: 40))
            backButton.setTitle("Regresar", for: .normal)
            backButton.backgroundColor = .red
            backButton.addTarget(context.coordinator, action: #selector(Coordinator.closeARView), for: .touchUpInside)
            arView.addSubview(backButton)
            
            // Etiqueta para mostrar mensajes de detección y anclaje
            let detectionLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
            detectionLabel.text = "Buscando superficie..."
            detectionLabel.textColor = .white
            detectionLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            detectionLabel.textAlignment = .center
            detectionLabel.font = UIFont.systemFont(ofSize: 16)
            detectionLabel.isHidden = true // Oculto al inicio
            arView.addSubview(detectionLabel)
            
            // Mejorar la iluminación con luz ambiental
            arView.environment.lighting.intensityExponent = 2.0
            
            // Luz direccional (simulación de luz solar)
            let directionalLight = DirectionalLight()
            directionalLight.light.color = .white
            directionalLight.light.intensity = 1000
            directionalLight.orientation = simd_quatf(angle: .pi / 4, axis: [1, 0, 0])
            
            // Anclar la luz al escenario
            let lightAnchor = AnchorEntity()
            lightAnchor.addChild(directionalLight)
            arView.scene.anchors.append(lightAnchor)
            
            // Detectar toques en la pantalla
            let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
            arView.addGestureRecognizer(tapGesture)
            
            // Enlazar elementos en el Coordinador
            context.coordinator.arView = arView
            context.coordinator.selectedModel = selectedModel
            context.coordinator.detectionLabel = detectionLabel
            
            return arView
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(showARView: $showARView)
        }
        
        class Coordinator: NSObject {
            var arView: ARView?
            var selectedModel: String = "" // Nombre del modelo seleccionado
            var cancellables = Set<AnyCancellable>()
            @Binding var showARView: Bool // Binding para controlar la vista AR
            var detectionLabel: UILabel? // Referencia a la etiqueta de detección
            
            init(showARView: Binding<Bool>) {
                self._showARView = showARView
            }
            
            @objc func handleTap(_ sender: UITapGestureRecognizer) {
                guard let arView = arView, let detectionLabel = detectionLabel else { return }
                
                let location = sender.location(in: arView)
                let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
                
                if let firstResult = results.first {
                    // Mostrar mensaje de detección y anclaje
                    detectionLabel.text = "Superficie detectada, anclando..."
                    detectionLabel.isHidden = false
                    
                    // Crear ancla en la ubicación detectada
                    let anchorEntity = AnchorEntity(world: firstResult.worldTransform)
                    
                    // Cargar el modelo seleccionado de forma asíncrona
                    Entity.loadAsync(named: selectedModel)
                        .sink { completion in
                            if case let .failure(error) = completion {
                                print("Error al cargar el modelo: \(error.localizedDescription)")
                            }
                        } receiveValue: { entity in
                            // Escalar el modelo para ajustarse al ancho de la pantalla
                            let screenWidth = UIScreen.main.bounds.width
                            let scaleFactor = Float(screenWidth / 1000)
                            entity.scale = SIMD3(repeating: scaleFactor)
                            
                            // Agregar el modelo a la ancla y al ARView
                            anchorEntity.addChild(entity)
                            arView.scene.anchors.append(anchorEntity)
                            
                            // Actualizar mensaje al finalizar
                            detectionLabel.text = "plato detectado"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                detectionLabel.isHidden = true // Ocultar mensaje después de 2 segundos
                            }
                        }
                        .store(in: &cancellables)
                } else {
                    // Mostrar mensaje si no se detectó una superficie
                    detectionLabel.text = "No detecto el plato"
                    detectionLabel.isHidden = false
                    
                    // Ocultar mensaje después de 2 segundos
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        detectionLabel.isHidden = true
                    }
                }
            }
            
            @objc func closeARView() {
                showARView = false // Regresa a la vista inicial
            }
        }
    }
    
    

