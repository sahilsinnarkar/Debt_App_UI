class Borrow {
  String? id, borrowText;
  bool isDone;

  Borrow({
    required this.id,
    required this.borrowText,
    this.isDone = false,
  });

  static List<Borrow> borrowList() {
    return [];
  }
}
