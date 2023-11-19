import Foundation
import SwiftUI


struct ProfileDetailView: UIViewRepresentable {
    
    
    //@State var username: String
    //var repositories: [Repository]?
    
    @State var repositories: [Repository] 
    let mainView = UIView()
    public let collectionView = UITableView(frame: .zero, style: .plain)
 
//    init(username: String) {
//        self.username = username
//        self.viewModel = ProfileDetailViewModel()
//        self.viewModel.getRepositoriesRequest(username: username)
//    }
    func makeUIView(context: Context) -> UIView {
        
        //let uiSearchbar = UISearchBar()
        
        context.coordinator.searchController.searchResultsUpdater = context.coordinator
        context.coordinator.searchController.obscuresBackgroundDuringPresentation = false
        context.coordinator.searchController.hidesNavigationBarDuringPresentation = false
        context.coordinator.searchController.searchBar.placeholder = "Search Repositories"
       
        let uiSearchbar = context.coordinator.searchController.searchBar
//        collectionView.inputViewController?.navigationController?.navigationBar = uiSearchbar
        collectionView.tableHeaderView = uiSearchbar
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        
        collectionView.register(CustomTableCell.self, forCellReuseIdentifier: CustomTableCell.identifier)
        //uiSearchbar.frame = .zero
        //rows = context.coordinator.rows
        mainView.addSubview(collectionView)
        mainView.addSubview(uiSearchbar)
        NSLayoutConstraint.activate([
//            uiSearchbar.topAnchor.constraint(equalTo: mainView.topAnchor),
//            uiSearchbar.leadingAnchor.constraint(equalTo: mainView.layoutMarginsGuide.leadingAnchor),
//            uiSearchbar.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
//            uiSearchbar.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            //uiSearchbar.topAnchor.constraint(equalTo: mainView.topAnchor),
            collectionView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: mainView.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)])
        
        return mainView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        print("Update UI Triggered")
        collectionView.reloadData()
    }
    

    func makeCoordinator() -> Coordinator {
        //viewModel.getRepositoriesRequest(username: username)
        
        return Coordinator(rows: _repositories)
    }

    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
        
        private(set) var rowsAll: [Repository] = []
//        @StateObject var viewModel = ProfileDetailViewModel()
        @State var rows: [Repository]
        private var count = 0
        internal let searchController = UISearchController(searchResultsController: nil)
        
        let cellSpacingHeight: CGFloat = 20
//        private var count = 0
        
        init(rows: State<[Repository]>) {
            _rows = rows
            self.rowsAll = rows.wrappedValue
            self.count = rows.wrappedValue.count
        }

        func updateSearchResults(for searchController: UISearchController) {
            print("Debug Print", searchController.searchBar.text)
            self.updateSearchController(searchBarText: searchController.searchBar.text)
           // print(self.rows)
           // count = self.rows.count
            //collectionView.re
    
        }
        
        public func inSearchMode(_ searchController: UISearchController) -> Bool{
            let isActive = searchController.isActive
            let searchText = searchController.searchBar.text ?? ""
            return isActive && !searchText.isEmpty
        }
        
        public func updateSearchController(searchBarText: String?){
            //self.rows = rowsAll
            if let searchText = searchBarText?.lowercased(){
                guard !searchText.isEmpty else {return}
                self.rows = self.rowsAll.filter({
                    $0.name.lowercased().contains(searchText)
                })
            }
            
            count = self.rows.count
            
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return count
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                return cellSpacingHeight
            }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: CustomTableCell.identifier, for: indexPath) as! CustomTableCell
            tableViewCell.setNeedsLayout()
            let inSearchMode = self.inSearchMode(searchController)
            //viewModel.fetch()
            if inSearchMode{
                tableViewCell.repositoryNameLabel.text = self.rows[indexPath.row].name
                tableViewCell.repositoryDescriptionLabel.text = self.rows[indexPath.row].description
                tableViewCell.repositoryTopicLabel.text = self.rows[indexPath.row].topics?.first
            }
            else{
                tableViewCell.repositoryNameLabel.text = self.rowsAll[indexPath.row].name
                tableViewCell.repositoryDescriptionLabel.text = self.rowsAll[indexPath.row].description
                tableViewCell.repositoryTopicLabel.text = self.rowsAll[indexPath.row].topics?.first
            }
           
            return tableViewCell
        }
        

        
        
    }
}



