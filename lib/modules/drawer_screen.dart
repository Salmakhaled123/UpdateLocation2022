import 'package:flutter/material.dart';
import 'package:mymap/components/components.dart';
import 'package:mymap/cubit/cubit.dart';
import 'package:mymap/modules/provider%20screen.dart';
class DrawerPart extends StatelessWidget
{
  const DrawerPart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    var cubit = LocationCubit.get(context);
    return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                accountName: Text('admin'),
                accountEmail: Text('admin@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: Text(
                    'A',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                )),
            buildDrawerItem(
                cubit.screensByDrawer, cubit.drawerIcons, context),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProviderScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.teal)),
                  child: Text('Provider mode')),
            )
          ],
        ));
  }
}
