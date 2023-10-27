import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.keyboardDismissMode = .onDrag
        self.collectionView.register(UINib(nibName: "MainGifCell", bundle: nil), forCellWithReuseIdentifier: "GifCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(userDidScroll: userDidScroll)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCell", for: indexPath) as? MainGifCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(withUrl: cellDataSource[indexPath.item].gifImage.rendition.url)
        return cell
    }

}
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userDidScroll = false
        viewModel.performSearchWithDelay(forString: searchBar.text)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if userDidScroll == false {
            self.collectionView.reloadData()
        }
        userDidScroll = true
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: viewModel.inset, left: viewModel.inset, bottom: viewModel.inset, right: viewModel.inset)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size: CGSize = collectionView.bounds.size
        guard size.width / size.height < 1 else {
            return viewModel.calculateWidthAndHeightOfCell(cellsPerRow: cellsPerRowLandscape, widthOfScreen: size.width)
        }
        return viewModel.calculateWidthAndHeightOfCell(cellsPerRow: cellsPerRowPortrait, widthOfScreen: size.width)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(viewModel.minimumLineSpacing)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(viewModel.minimumInteritemSpacing)
    }
}
