///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  16 Dec 2018
///
///

import 'package:flutter/material.dart'
    show
        AppBar,
        Brightness,
        BuildContext,
        Colors,
        CustomScrollView,
        FlatButton,
        Icon,
        Icons,
        Key,
        MaterialPageRoute,
        Navigator,
        Scaffold,
        SliverChildListDelegate,
        SliverList,
        StatelessWidget,
        Theme,
        ThemeData,
        Widget;

import 'package:mxc_application/app.dart' show App;

import 'package:mxc_application/view.dart'
    show
        EditBarButton,
        HomeBarButton,
        SearchBarButton,
        SimpleBottomAppBar,
        showBox;

import '../../model.dart' show Contact;

import '../../view.dart' show AddContactPage;

import '../../controller.dart' show Controller;

enum AppBarBehavior { normal, pinned, floating, snapping }

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage({this.contact, Key key}) : super(key: key) {
    Controller.edit.init(contact);
  }
  final Object contact;

  final double _appBarHeight = 256.0;

  final AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: Brightness.light,
          primarySwatch: App.colorTheme, //Colors.indigo,
          platform: Theme.of(context).platform,
        ),
        child: Scaffold(
            appBar: AppBar(title: Controller.edit.displayName.text, actions: [
              FlatButton(
                  child: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    showBox(text: 'Delete this contact?', context: context)
                        .then((bool delete) {
                      if (delete)
                        Controller.delete(contact).then((bool delete) {
                          if (delete) Controller.list.refresh();
                          Navigator.of(context).pop();
                        });
                    });
                  }),
            ]),
            bottomNavigationBar: SimpleBottomAppBar(
              button01: HomeBarButton(onPressed: () {
                Navigator.of(context).pop();
              }),
              button02: SearchBarButton(),
              button03: EditBarButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddContactPage(
                        contact: contact, title: 'Edit a contact')));
              }),
            ),
            body: CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Controller.edit.givenName.onListTile(tap: () {
                    editContact(contact, context);
                  }),
                  Controller.edit.middleName.onListTile(tap: () {
                    editContact(contact, context);
                  }),
                  Controller.edit.familyName.onListTile(tap: () {
                    editContact(contact, context);
                  }),
                  Controller.edit.prefix.onListTile(tap: () {
                    editContact(contact, context);
                  }),
                  Controller.edit.suffix.onListTile(tap: () {
                    editContact(contact, context);
                  }),
                  Controller.edit.company.onListTile(tap: () {
                    editContact(contact, context);
                  }),
                  Controller.edit.jobTitle.onListTile(tap: () {
                    editContact(contact, context);
                  }),
                  Controller.edit.phone.listItems,
                  Controller.edit.email.listItems,
                ]),
              )
            ])));
  }

  editContact(Contact contact, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            AddContactPage(contact: contact, title: 'Edit a contact')));
  }
}
