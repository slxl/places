import SwiftUI

// MARK: - CreateLocationComponent.UI

extension CreateLocationComponent {
    struct UI: View {
        @ObservedObject var viewModel: ViewModel

        @Environment(\.presentationMode)
        var presentationMode

        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Create new location")) {
                        TextField("Name", text: $viewModel.name)
                            .accessibilityLabel("Location Name")
                            .accessibilityHint("Enter the name of the location")

                        TextField("Latitude", text: $viewModel.latitude)
                            .accessibilityLabel("Latitude")
                            .accessibilityHint("Enter the latitude of the location in decimal format")

                        TextField("Longitude", text: $viewModel.longitude)
                            .accessibilityLabel("Longitude")
                            .accessibilityHint("Enter the longitude of the location in decimal format")
                    }
                }
                .navigationTitle("Create location")
                .navigationBarItems(
                    leading: Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .accessibilityLabel("Dismiss view")
                    .accessibilityHint("Dismisses current view"),
                    trailing: Button("Save") {
                        if viewModel.validateAndSave() {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(!viewModel.isValid)
                    .accessibilityLabel("Save Location")
                    .accessibilityHint("Saves the new location if the entered details are valid")
                )
            }
        }
    }
}
