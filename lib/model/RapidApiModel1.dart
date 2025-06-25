

import 'dart:convert';

RapidApiModel1 rapidApiModel1FromJson(String str) => RapidApiModel1.fromJson(json.decode(str));

String rapidApiModel1ToJson(RapidApiModel1 data) => json.encode(data.toJson());

class RapidApiModel1 {
  String? status;
  List<Item>? items;

  RapidApiModel1({
    this.status,
    this.items,
  });

  factory RapidApiModel1.fromJson(Map<String, dynamic> json) => RapidApiModel1(
    status: json["status"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String? timestamp;
  String? title;
  String? snippet;
  Images? images;
  List<Item>? subnews;
  bool? hasSubnews;
  String? newsUrl;
  String? publisher;

  Item({
    this.timestamp,
    this.title,
    this.snippet,
    this.images,
    this.subnews,
    this.hasSubnews,
    this.newsUrl,
    this.publisher,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    timestamp: json["timestamp"],
    title: json["title"],
    snippet: json["snippet"],
    images: json["images"] == null ? null : Images.fromJson(json["images"]),
    subnews: json["subnews"] == null ? [] : List<Item>.from(json["subnews"]!.map((x) => Item.fromJson(x))),
    hasSubnews: json["hasSubnews"],
    newsUrl: json["newsUrl"],
    publisher: json["publisher"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "title": title,
    "snippet": snippet,
    "images": images?.toJson(),
    "subnews": subnews == null ? [] : List<dynamic>.from(subnews!.map((x) => x.toJson())),
    "hasSubnews": hasSubnews,
    "newsUrl": newsUrl,
    "publisher": publisher,
  };
}

class Images {
  String? thumbnail;
  String? thumbnailProxied;

  Images({
    this.thumbnail,
    this.thumbnailProxied,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    thumbnail: json["thumbnail"],
    thumbnailProxied: json["thumbnailProxied"],
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail,
    "thumbnailProxied": thumbnailProxied,
  };
}
