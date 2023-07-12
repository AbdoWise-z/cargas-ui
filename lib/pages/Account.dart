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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [

          const Expanded(flex: 1, child: SizedBox(),),

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

          const Expanded(flex: 1, child: SizedBox(),),

          Expanded(flex: 11, child: Column(
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
                maxLines: 2,
              ),
            ],
          ),),
          const Expanded(flex: 1, child: SizedBox(),),
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
                    scaleY: 1.3,
                    child: Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.green, Colors.yellow],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(70, 100)),
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
                padding: const EdgeInsets.fromLTRB(220, 40, 0, 0),
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
                          image: AssetImage(
                              "assets/images/default_profile_green.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(340, 0, 0, 0),
                child: IconButton(
                  onPressed: ()async{
                    await Navigator.pushNamed(context, '/editProfile');
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                  iconSize: 20,
                ),
              ),
            ],
          ),
          Container(
            height: 400,
            width: 400,
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoTile(
                  type: "Nick Name",
                  info: name,
                  iconColor: Colors.orange,
                  icon: Icons.person_outline,),

                InfoTile(
                  type: "Phone Number",
                  info: phoneNumber,
                  iconColor: Colors.blue,
                  icon: Icons.phone,),

                InfoTile(
                  type: "Address",
                  info: address,
                  iconColor: Colors.pink,
                  icon: Icons.apartment,),

                InfoTile(
                  type: "Balance",
                  info: "$balance L.E.",
                  iconColor: Colors.green,
                  icon: Icons.attach_money,),
              ],
            ),
          )
        ]
    );
  }
}