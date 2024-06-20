import "package:flutter/material.dart";
import "package:to_do_app/constants/colors.dart";
import "package:to_do_app/model/borrow.dart";

class Borrowings extends StatelessWidget {
  final Borrow borrow;
  // ignore: prefer_typing_uninitialized_variables
  final onBorrowChanged, onDeleteItem;
  const Borrowings(
      {super.key,
      required this.borrow,
      this.onBorrowChanged,
      this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onBorrowChanged(borrow);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          borrow.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Text(
          borrow.borrowText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: borrow.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(borrow.id);
            },
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
