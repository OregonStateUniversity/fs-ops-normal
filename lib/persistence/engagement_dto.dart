class EngagementDTO {
  final String name;
  final bool active;
  final DateTime createdAt;

  EngagementDTO(
      {required this.name, required this.active, required this.createdAt});
  @override
  String toString() => 'Name: $name, Active: $active, Created At: $createdAt';
}
