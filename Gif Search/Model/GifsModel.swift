import Foundation

struct GifModel: Decodable {
    let gifs:[Gif]
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}
struct Gif: Decodable {
    let gifImage: GifImage
    enum CodingKeys: String, CodingKey {
        case gifImage = "images"
    }
    struct GifImage: Decodable {
        let rendition: Rendition
        enum CodingKeys: String, CodingKey {
            case rendition = "fixed_height_downsampled" //width 200
        }
        struct Rendition: Decodable {
            let url: URL
        }
    }
}

