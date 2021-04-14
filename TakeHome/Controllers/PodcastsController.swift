
import UIKit

class PodcastsController: UIViewController {
    
    //MARK: - Constants
    
    private let cellIdentifier = "Podcast Cell"
    private let delay: Double = 0.5
    
    //MARK: - Properties
    
    let dataProvider = SearchResultDataProvider()
    let podcastManager = PodcastPageManager()
    var podcastList: [Podcast] = []
    var debouncer: Debouncer?
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var notificationLabel: UILabel!
    
    //MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDebouncer()
        registerPodcastCell()
    }
    
    //MARK: - Actions
    
    @IBAction func searchFieldTextChanged(_ sender: UITextField) {
        resetSearch()
        if !sender.text!.isEmpty {
            debouncer?.call()
        } else {
            debouncer?.invalidateTimer()
            clearTableView()
        }
    }
    
    //MARK: - Methods
    
    private func createDebouncer() {
        debouncer = Debouncer(delay: delay, delegate: self)
    }
    
    private func registerPodcastCell() {
        tableView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setNoResults() {
        showTableView(show: false)
        notificationLabel.text = "No results"
    }
    
    private func resetSearch() {
        podcastList.removeAll()
        podcastManager.resetCurrentPage()
        clearTableView()
    }
    
    private func clearTableView() {
        showTableView(show: false)
        notificationLabel.text = ""
    }
    
    private func showTableView(show: Bool) {
        tableView.isHidden = !show
    }
    
    private func setLoadingNotification() {
        notificationLabel.text = "Loading..."
    }
}

//MARK: - UITableViewDelegate

extension PodcastsController: UITableViewDelegate {
    
    // Pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == podcastList.count - 2 {
            podcastManager.increaseCurrentPage()
            executeCallback()
        }
    }
}

//MARK: - UITableViewDataSource

extension PodcastsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PodcastCell
        let podcast = podcastList[indexPath.row]
        cell.setUp(forPodcast: podcast)
        return cell
    }
}

//MARK: - UITextFieldDelegate

extension PodcastsController: UITextFieldDelegate {    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        debouncer?.invalidateTimer()
        clearTableView()
        return true
    }
}

//MARK: - DebouncerDelegate

extension PodcastsController: DebouncerDelegate {
    func executeCallback() {
        guard let searchRequest = searchTextField.text else { return }
        setLoadingNotification()
        dataProvider.getSearch(page: podcastManager.getCurrentPage(), query: searchRequest, success: { podcasts in
            DispatchQueue.main.async {
                self.podcastList.append(contentsOf: podcasts)
                self.showTableView(show: true)
                self.tableView.reloadData()
            }
        }, failure: { [weak self] _ in
            // For a list of results the last page comes without results and throws failure. So show 'No results' only if no results came for the first page
            if self?.podcastManager.getCurrentPage() == 1 {
                self?.setNoResults()
            }
        })
    }
}

