import 'package:flutter/material.dart';
import 'package:maimaid_interview/constant/colors.dart'; // Ensure this contains necessary color definitions
import 'package:maimaid_interview/screens/create_screen/create_screen.dart';
import 'package:maimaid_interview/screens/home_screen/user_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 55.0, vertical: 55.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "User List",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateScreen()));
                    },
                    child: const CircleAvatar(
                      backgroundColor: ColorName.lightgray,
                      child: Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Non Selected'),
                  Tab(text: 'Selected'),
                ],
                indicatorColor: const Color.fromARGB(255, 255, 170, 0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Total 03 items',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  UserList(),
                  UserList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
