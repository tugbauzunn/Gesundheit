
class CareLevelRequest {
  final String id;
  final int currentLevel;
  final int desiredLevel;
  final String reason;
  final DateTime createdAt;
  final String? attachedPdfId;  // YENİ: PDF ID'si

  CareLevelRequest({
    required this.id,
    required this.currentLevel,
    required this.desiredLevel,
    required this.reason,
    required this.createdAt,
    this.attachedPdfId,  // YENİ
  });

  /// API'ye gönderilecek JSON format
  Map<String, dynamic> toCreateJson() {
    return {
      'currentLevel': currentLevel,
      'desiredLevel': desiredLevel,
      'reason': reason,
      'attachedPdfId': attachedPdfId,  // YENİ: PDF ID'sini dahil et
    };
  }

  /// API'den gelen JSON'dan model oluştur
  factory CareLevelRequest.fromJson(Map<String, dynamic> json) {
    return CareLevelRequest(
      id: json['id'],
      currentLevel: json['currentLevel'],
      desiredLevel: json['desiredLevel'],
      reason: json['reason'],
      createdAt: DateTime.parse(json['createdAt']),
      attachedPdfId: json['attachedPdfId'],  // YENİ
    );
  }

  /// Model'den JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentLevel': currentLevel,
      'desiredLevel': desiredLevel,
      'reason': reason,
      'createdAt': createdAt.toIso8601String(),
      'attachedPdfId': attachedPdfId,  // YENİ
    };
  }

  /// Debug amaçlı string representation
  @override
  String toString() {
    return 'CareLevelRequest{id: $id, currentLevel: $currentLevel, desiredLevel: $desiredLevel, reason: $reason, attachedPdfId: $attachedPdfId}';
  }
}
