import Foundation

class MainViewModel {
    
    //constants for collectionView Flowlayout
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    var timer: Timer?
    
    var errorNotification: Observable<String> = Observable("")
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[Gif]> = Observable([])
    var dataSource: [Gif]?
    
    func numberOfItemsInSection(userDidScroll: Bool) -> Int {
        guard let count = self.dataSource?.count else { return 0 }
        guard count > 0 else { return 0 }
        guard userDidScroll else { return 2 }
        return count
    }
    func getGifsData(forString text: String) {
        isLoading.value = true
        NetworkManager.getGifImages(forString: text) { [weak self] gifs, error in
            self?.isLoading.value = false
            if let gifs = gifs {
                self?.dataSource = gifs
                self?.cellDataSource.value = self?.dataSource ?? []
            } else {
                switch error?.responseCode {
                case 414:
                    self?.errorNotification.value = "The length of the search query should not exceed 50 characters"
                default:
                    self?.errorNotification.value = "Please conect to internet"
                }
            }
        }
    }
  
    func performSearchWithDelay(forString text: String?){
        guard let text = text else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { [weak self] _ in
            self?.getGifsData(forString: text)
        })
    }

    func calculateWidthAndHeightOfCell(cellsPerRow: Int, widthOfScreen: Double) -> CGSize {
        let marginsAndInsets = inset * 2 + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((widthOfScreen - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
