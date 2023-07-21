import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      itemCount: 10,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.amber,
        // indent: 70,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
          ),
          title: Text(
            'Name',
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              'Address',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          trailing: Text(
            'Time',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        );
      },
    );
  }
}
