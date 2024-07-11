import SwiftUI

// MARK: - LocationListComponent.ItemView

extension LocationListComponent {
    struct ItemView: View {
        var name: String
        var coordinates: String

        init(viewModel: LocationItemViewModel) {
            self.name = viewModel.name
            self.coordinates = viewModel.coordinatesString
        }

        var body: some View {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .foregroundColor(.blue)
                    .accessibilityLabel("Location Icon")

                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .accessibilityLabel("Location Name")
                        .accessibilityValue(name)

                    Text(coordinates)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel("Coordinates")
                        .accessibilityValue(coordinates)
                }
                .padding(.vertical)

                Spacer()
            }
            .background(.accent)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.horizontal)
            .accessibilityElement(children: .combine)
            .accessibilityHint("Displays location information with coordinates.")
        }
    }
}

#if DEBUG
#Preview {
    LocationListComponent.ItemView(
        viewModel: .init(
            location: .init(
                name: "Sweet Home Alabama",
                coordinates: .init(
                    latitude: 55.050,
                    longitude: 82.950
                )
            )
        )
    )
}
#endif
