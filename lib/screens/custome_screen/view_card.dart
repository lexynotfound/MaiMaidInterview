import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewCard extends StatelessWidget {
  final String imageUrl;
  final String firstName;
  final String lastName;
  final String email;

  const ViewCard({
    super.key,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
          10.0), // Ensures outer spacing around the container
      padding: const EdgeInsets.all(10.0), // Inner padding within the container
      decoration: BoxDecoration(
        color: Colors.white, // Explicitly set the background color to white
        borderRadius:
            BorderRadius.circular(20), // Rounded corners with a 20 radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow with 50% opacity
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 89.0,
            height: 89.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(20)), // Rounded corners for the image
              image: DecorationImage(
                image: NetworkImage(imageUrl), // Load image from network
                fit: BoxFit.cover, // Cover the entire space of the box
              ),
            ),
          ),
          const SizedBox(width: 16), // Space between the image and the text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align text to the start of the axis
              children: <Widget>[
                Text(
                  '$firstName $lastName', // Display name
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email, // Display email
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600]), // Grey color for the email text
                ),
              ],
            ),
          ),
          Transform.rotate(
            angle: -90 *
                3.141592653589793238 /
                180, // Rotate the icon by -90 degrees
            child: PopupMenuButton<String>(
              padding: const EdgeInsets.symmetric(
                  horizontal: 3.89), // Padding around the icon
              icon: const Icon(Icons.more_vert,
                  size: 23.3), // 'more_vert' icon to indicate a menu
              onSelected: (String result) {
                switch (result) {
                  case 'Select':
                    break;
                  case 'Update':
                    break;
                  case 'Delete':
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                    value: 'Select', child: Text('Select')),
                const PopupMenuItem<String>(
                    value: 'Update', child: Text('Update')),
                const PopupMenuItem<String>(
                    value: 'Delete', child: Text('Delete')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
