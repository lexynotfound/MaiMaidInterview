import 'package:flutter/material.dart';
import 'package:maimaid_interview/constant/colors.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String? selectedJob;

  void _openJobSelection(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap:
              () {}, // untuk mencegah menutup modal ketika area konten ditekan
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      "Pilih Pekerjaan",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                ListTile(
                  title: Text('Front End'),
                  trailing: Icon(Icons.arrow_circle_right_outlined),
                  onTap: () => Navigator.pop(context, 'Front End'),
                ),
                ListTile(
                  title: Text('Back End'),
                  trailing: Icon(Icons.arrow_circle_right_outlined),
                  onTap: () => Navigator.pop(context, 'Back End'),
                ),
                ListTile(
                  title: Text('Data Analyst'),
                  trailing: Icon(Icons.arrow_circle_right_outlined),
                  onTap: () => Navigator.pop(context, 'Data Analyst'),
                ),

              ],
            ),
          ),
        );
      },
    );
    if (result != null) {
      setState(() => selectedJob = result);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 10,
              ), // Add padding to push the icon slightly to the right
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const CircleAvatar(
              radius: 20, // Optional: Adjust the size of the CircleAvatar
              backgroundColor:
                  ColorName.lightgray, // Light background for the icon
              child: Icon(Icons.close,
                  color: Colors.black), // Use black icon for visibility
            ),
          ),
        ),
        title: const Text(
          'Create', 
          style: TextStyle(
            color: Colors.black
          )
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20), // Padding to Name Label
            const Text('Name', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            const SizedBox(height: 34), // Space to Jobs Label
            const Text('Jobs', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => _openJobSelection(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedJob ?? 'Select a job'),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 110), // Space to Create Button
            SizedBox(
              width: 427,
              height: 62,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFFFF6D00), // Assuming the orange color from the image
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // All corners rounded uniformly
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
