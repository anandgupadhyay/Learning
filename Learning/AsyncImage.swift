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


//AsyncImage Error Handling

AsyncImage(url: URL(string: "https://picsum.photos/i/237/400/400")) { phase in
    if let image = phase.image {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
    } else if phase.error != nil {
        Text("No image available")
    } else {
        Image(systemName: "photo")
    }
}
.frame(width: 250, height: 250)
.border(Color.gray)
