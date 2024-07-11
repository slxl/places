import SwiftUI

// MARK: - LocationListComponent.LocationListView

extension LocationListComponent {
    struct LocationListView: View {
        @ObservedObject var viewModel: ViewModel

        init(viewModel: ViewModel) {
            self.viewModel = viewModel
        }

        var body: some View {
            NavigationView {
                Group {
                    if viewModel.isRefreshing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(2)
                            .tint(.accent)
                    } else {
                        ScrollView {
                            VStack {
                                ForEach(viewModel.items) { itemViewModel in
                                    LocationListComponent.ItemView(viewModel: itemViewModel)
                                        .onTapGesture {
                                            viewModel.onLocationTap(item: itemViewModel)
                                        }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Locations")
                .navigationBarItems(
                    trailing: Button {
                        viewModel.onCreateTap()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(.cyan)
                    .symbolEffect(.bounce, value: viewModel.showingAddLocation)
                )
                .sheet(isPresented: $viewModel.showingAddLocation) {
                    CreateLocationComponent.UI(viewModel: viewModel.createLocationViewModel())
                }
            }
            .onAppear(perform: {
                viewModel.loadData()
            })
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#if DEBUG
#Preview {
    LocationListComponent.LocationListView(
        viewModel: .init(
            deps: .init(
                service: LocationMockService(),
                router: Router()
            )
        )
    )
}
#endif
