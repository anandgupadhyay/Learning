AsyncImage(url: URL(string: "https://picsum.photos/id/237/400/400")) { image in
    image
        .resizable()
        .aspectRatio(contentMode: .fill)
} placeholder: {
    Color.gray
}
.frame(width: 250, height: 250)


//AsyncImage with custom placeholder while loading
AsyncImage(url: URL(string: "https://picsum.photos/id/237/400/400")) { image in
    image
        .resizable()
        .aspectRatio(contentMode: .fill)
} placeholder: {
    Image(systemName: "photo.fill")
}
.frame(width: 250, height: 250)
.border(Color.gray)


