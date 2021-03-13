import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class InviteFriendsView extends StatefulWidget {
  @override
  _InviteFriendsViewState createState() => _InviteFriendsViewState();
}

class _InviteFriendsViewState extends State<InviteFriendsView> {
  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arkadaşlarını Davet Et"),
      ),
      /*body: FutureBuilder<List<Contact>>(
        future: getPermissions(),
        builder: (context, result) {
          return result.hasData
              ? ListView.builder(
                  itemCount: result.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("result.data[index].displayName"),
                      subtitle:
                          Text("result.data[index].phones.elementAt(0).value"),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),*/
    );
  }

  /*Future<List<Contact>> getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> _contacts = (await ContactsService.getContacts()).toList();
      setState(() {
        contacts = _contacts;
      });
      print(_contacts.first.givenName);
      return contacts;
    }
  }*/
}
