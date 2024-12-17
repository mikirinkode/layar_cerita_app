class AddStoryBody {
  final String description;

  AddStoryBody({required this.description});

  Map<String, String> toJson() => {"description": description};
}
