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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Card(
            elevation: 4,
            shape: const CircleBorder(),
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
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(info,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
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
                    alignment: Alignment.bottomLeft,
                    scaleX: 1.2,
                    scaleY: 1.18,
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
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(280, 40, 30, 0),
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
                          image: AssetImage("assets/images/default_profile_green.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 300,
            width: 400,
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoTile(type: "Nick Name", info: name, iconColor: Colors.orange,icon: Icons.person_outline,),

                InfoTile(type: "Phone Number", info: phoneNumber, iconColor: Colors.blue,icon: Icons.phone,),

                InfoTile(type: "Address", info: address, iconColor: Colors.pink,icon: Icons.apartment,),

                InfoTile(type: "Balance", info: "$balance\$", iconColor: Colors.green,icon: Icons.attach_money,),
              ],
            ),
          )
        ]
    );
  }
}