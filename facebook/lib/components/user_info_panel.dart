import 'package:facebook/models/user.dart';
import 'package:flutter/material.dart';

class UserInfoPanel extends StatefulWidget {
  final User user;

  const UserInfoPanel({required this.user, Key? key}) : super(key: key);

  @override
  _UserInfoPanelState createState() => _UserInfoPanelState();
}

class _UserInfoPanelState extends State<UserInfoPanel> {
  late bool isExpanded; //ricorda se il panel è aperto
  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool panelState) {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            isExpanded: isExpanded,
            headerBuilder: (buildContext, bool isExpanded) {
              //intestazione del panel
              return ListTile(
                title: Text(
                    'Info about ${widget.user.firstName} ${widget.user.lastName}'),
              );
            },
            //contenuto del panel
            body: Card(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.phone),
                      Text(widget.user.phone!),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.email),
                      Text(widget.user.email!),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(widget.user.gender == 'male'
                          ? Icons.male
                          : Icons.female),
                      Text(widget.user.gender!),
                    ],
                  ),
                ),
                if (widget.user.location != null &&
                    widget.user.location!.city != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.place),
                        Text(widget.user.location!.city!),
                      ],
                    ),
                  ),
              ],
            )),
          ),
        ]);
  }
}
