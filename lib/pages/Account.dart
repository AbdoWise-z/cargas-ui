import 'package:flutter/material.dart';
import 'package:cargas/base.dart';

class InfoTile extends StatelessWidget {
  InfoTile({required this.type,required this.info,required this.iconColor,required this.icon});

  final String type;
  final Color? iconColor;
  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 40,),
        Card(
          elevation: 4,
          shape: CircleBorder(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              child: Icon(
                icon,
                size: 20,
                color: iconColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type,
              style:TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            Text(info,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),),
          ],
        )
      ],
    );
  }
}

class AccountPage extends StatefulWidget {

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Stack(
            children: [
              Transform.rotate(
                  angle: -0.42,
                  alignment: Alignment.centerLeft,
                  child: Transform.scale(
                    alignment: Alignment.centerLeft,
                    scaleX: 2,
                    child: Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.green, Colors.yellow],
                        ),
                        borderRadius: BorderRadius.only(bottomLeft:Radius.elliptical(70, 100)),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(280, 40, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.yellow.withOpacity(0.2),
                      width: 4,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("default_profile_green.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              InfoTile(type: "Nick Name", info: name, iconColor: Colors.orange,icon: Icons.person_outline,),
              SizedBox(height: 30,),
              InfoTile(type: "Phone Number", info: phoneNumber, iconColor: Colors.blue,icon: Icons.phone,),
              SizedBox(height: 30,),
              InfoTile(type: "Address", info: address, iconColor: Colors.pink,icon: Icons.apartment,),
              SizedBox(height: 30,),
              InfoTile(type: "Balance", info: "$balance\$", iconColor: Colors.green,icon: Icons.attach_money,),
              SizedBox(height: 30,),
            ],
          )
        ]

    );
  }
}