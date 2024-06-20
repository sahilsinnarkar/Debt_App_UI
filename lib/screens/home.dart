import "package:flutter/material.dart";
import "package:to_do_app/constants/colors.dart";
import "package:to_do_app/model/borrow.dart";
import "package:to_do_app/widgets/borrowings.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final borrowedList = Borrow.borrowList();
  List<Borrow> _foundBorrow = [];
  final _borrowController = TextEditingController();

  @override
  void initState() {
    _foundBorrow = borrowedList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: const Text(
                          'All Borrowings',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Borrow borrow in _foundBorrow.reversed)
                        Borrowings(
                          borrow: borrow,
                          onBorrowChanged: _handleBorrowChange,
                          onDeleteItem: _deleteBorrowItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: _borrowController,
                      decoration: const InputDecoration(
                        hintText: 'Add New item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addBorrowItem(_borrowController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleBorrowChange(Borrow borrow) {
    setState(() {
      borrow.isDone = !borrow.isDone;
    });
  }

  void _deleteBorrowItem(String id) {
    setState(() {
      borrowedList.removeWhere((item) => item.id == id);
    });
  }

  void _addBorrowItem(String borrow) {
    setState(() {
      borrowedList.add(
        Borrow(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          borrowText: borrow,
        ),
      );
    });
    _borrowController.clear();
  }

  void _runFilter(String entredKeyword) {
    List<Borrow> results = [];
    if (entredKeyword.isEmpty) {
      results = borrowedList;
    } else {
      results = borrowedList
          .where((item) => item.borrowText!
              .toLowerCase()
              .contains(entredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundBorrow = results;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGrey,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Money Record",
            style: TextStyle(color: tdBlack),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/linked_in_pic.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}
