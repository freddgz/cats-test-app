import 'dart:convert';

ImageResponse imageResponseFromJson(String str) =>
    ImageResponse.fromJson(json.decode(str));
String imageResponseToJson(ImageResponse data) => json.encode(data.toJson());

List<ImageResponse> imageResponseListFromJson(String str) =>
    List<ImageResponse>.from(
        json.decode(str).map((x) => ImageResponse.fromJson(x)));

class ImageResponse {
  String id;
  String url;
  int width;
  int height;

  ImageResponse({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
