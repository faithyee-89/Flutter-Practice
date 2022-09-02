class FriendsModel {
  String? imageUrl;
  String? name;
  String? indexLetter;
  String? imageAssets;
  FriendsModel({
    this.imageUrl,
    this.name,
    this.indexLetter,
    this.imageAssets,
  });

  FriendsModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    indexLetter = json['indexLetter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['indexLetter'] = this.indexLetter;
    return data;
  }
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
