import SwiftData
import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    @Environment(\.modelContext) private var context

    @State private var showArea = false
    @State private var showAreaDelete = false
    @State private var showAreaDeleteSuccess = false
    
    @State private var showMyRecepies = false
    
    @State private var showCategory = false
    @State private var showCateDelete = false
    @State private var showCateDeleteSuccess = false
    
    @State private var showIngredient = false
    @State private var showIngrDelete = false
    @State private var showIngrDeleteSuccess = false
    
    @State private var showRecDelete = false
    @State private var showRecDeleteSuccess = false
    
    @State private var showArchive = false
    @State private var showDatabaseLocation = false
    @State private var databasePath = ""
    
    

    var body: some View {
        NavigationStack {
            List {
                // Button for AreaView
                Button(action: { showArea.toggle() }) {
                    Label("Redigere land", systemImage: "flag.circle.fill")
                }

                // Button for CategoryEditView
                Button(action: { showCategory.toggle() }) {
                    Label("Redigere kategorier", systemImage: "list.clipboard.fill")
                }

                // Button for IngredientEditView
                Button(action: { showMyRecepies.toggle() }) {
                    Label("Redigere lagrede oppskrifter", systemImage: "fork.knife.circle.fill")
                }
                
                Button(action: { showIngredient.toggle() }) {
                    Label("Redigere ingredienser", systemImage: "carrot.fill")
                }
                Section
                {
                deleteIngredients
                deleteAreas
                deleteRecepies
                deleteCategories
                }


                Section {
                    Button(action: { showArchive.toggle() }) {
                        Label("Administrere arkiv", systemImage: "archivebox.fill")
                    }
                }
              

                Section {
                    Button(action: {
                        showDatabaseLocation.toggle()
                        if showDatabaseLocation {
                            fetchDatabasePath()
                        }
                    }) {
                        Label(showDatabaseLocation ? "Skjul database lokasjon" : "Vis database lokasjon", systemImage: "square.stack.3d.up.fill")
                    }

                    if showDatabaseLocation && !databasePath.isEmpty {
                        Text(databasePath)
                    }
                }
                
                Section {
                    Toggle(isOn: $darkMode) {
                        Label("Aktiver mørk modus", systemImage: darkMode ? "moon.zzz" : "moon.circle")
                    }
                }
            }
            .navigationTitle("Innstillinger")
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .sheet(isPresented: $showArea) {
            ImportAreasView()
        }
        .sheet(isPresented: $showCategory) {
            CategoryImport()
        }
        .sheet(isPresented: $showIngredient) {
            ImportIngredientView()
        }
        .sheet(isPresented: $showMyRecepies) {
            MyRecepiesImport()
        }
        .sheet(isPresented: $showArchive) {
            ArchiveView()
        }
    }
    
    var deleteIngredients: some View {
        Button
        {
          showIngrDelete.toggle()
        }
        label:
        {
          Label("Slette alle ingredienser", systemImage: "trash.fill").tint(.red)
        }
        .alert("Vil du slette ingredienser?", isPresented: $showIngrDelete)
        {
          Button("Nei", role: .cancel) {}
          Button("Ja", role: .destructive)
          {
            do
            {
              try context.delete(model: IngredientDB.self)
              showIngrDeleteSuccess = true
            }
            catch
            {
              print(error)
            }
          }
        }
        message:
        {
          Text("Alle ingredienser slettes fra databasen.")
        }
        .alert("Alle ingredienser ble slettet fra databasen.", isPresented: $showIngrDeleteSuccess){}
    }
    
    var deleteAreas: some View {
        Button
        {
          showAreaDelete.toggle()
        }
        label:
        {
          Label("Slette alle landområder", systemImage: "trash.fill").tint(.red)
        }
        .alert("Vil du slette landområder?", isPresented: $showAreaDelete)
        {
          Button("Nei", role: .cancel) {}
          Button("Ja", role: .destructive)
          {
            do
            {
              try context.delete(model: AreaDB.self)
              showAreaDeleteSuccess = true
            }
            catch
            {
              print(error)
            }
          }
        }
        message:
        {
          Text("Alle landområder slettes fra databasen.")
        }
        .alert("Alle landområder ble slettet fra databasen.", isPresented: $showAreaDeleteSuccess){}
    }
    
    var deleteCategories: some View {
        Button
        {
          showCateDelete.toggle()
        }
        label:
        {
          Label("Slette alle kategorier", systemImage: "trash.fill").tint(.red)
        }
        .alert("Vil du slette kategorier?", isPresented: $showCateDelete)
        {
          Button("Nei", role: .cancel) {}
          Button("Ja", role: .destructive)
          {
            do
            {
              try context.delete(model: CategoryDB.self)
              showCateDeleteSuccess = true
            }
            catch
            {
              print(error)
            }
          }
        }
        message:
        {
          Text("Alle kategorier slettes fra databasen.")
        }
        .alert("Alle kategorier ble slettet fra databasen.", isPresented: $showCateDeleteSuccess){}
    }
    
    var deleteRecepies: some View {
        Button
        {
          showRecDelete.toggle()
        }
        label:
        {
            Label("Slette alle lagrede oppskrifter", systemImage: "trash.fill").tint(.red)
        }
        .alert("Vil du slette alle lagrede oppskrifter?", isPresented: $showRecDelete)
        {
          Button("Nei", role: .cancel) {}
          Button("Ja", role: .destructive)
          {
            do
            {
              try context.delete(model: MealDB.self)
              showRecDeleteSuccess = true
            }
            catch
            {
              print(error)
            }
          }
        }
        message:
        {
          Text("Alle lagrede oppskrifter slettes fra databasen.")
        }
        .alert("Alle lagrede oppskrifter ble slettet fra databasen.", isPresented: $showRecDeleteSuccess){}
    }

    private func fetchDatabasePath() {
        guard let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            databasePath = "Unable to find path"
            return
        }

        let databaseURL = appSupportURL.appendingPathComponent("default.store")
        if FileManager.default.fileExists(atPath: databaseURL.path) {
            databasePath = databaseURL.absoluteString
        } else {
            databasePath = "Database file does not exist"
        }
    }
}

// Preview
#Preview {
    SettingsView()
}

