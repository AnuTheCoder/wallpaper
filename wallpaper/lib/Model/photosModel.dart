class PhotosModel{
  String imageSrc;
  String photographer;

  PhotosModel({
    required this.photographer,
    required this.imageSrc
});

static fromAPI2APP(Map<String, dynamic> photoMap){
  return PhotosModel(photographer: photoMap["photographer"],
  imageSrc: (photoMap["src"])["portrait"]);
}

}