import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.network_cell),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Precious Oladele', style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text('of_devprecious')
                  ],
                ),
                CircleAvatar(
                  radius: 35,
                ),
              ],
            ),
            SizedBox(height: 30,),
            Text('Hi i am a developer'),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 20,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 40,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 55,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 70,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('104 followers')
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white, strokeAlign: 3),

                      )
                    ),
                    onPressed: () {}, child: Text('Edit Profile', style: TextStyle(
                    color: Colors.white,
                  ),),),
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white, strokeAlign: 3),

                        )
                    ),
                    onPressed: () {}, child: Text('Share Profile', style: TextStyle(
                    color: Colors.white,
                  ),),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
