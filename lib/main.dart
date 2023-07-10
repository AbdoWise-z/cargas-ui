import 'package:cargas/Home.dart';
import 'package:cargas/ShopItem.dart';
import 'package:cargas/pages/Map.dart';
import 'package:flutter/material.dart';
import 'base.dart';

void main() {
  // adding dummy values for testing ..
  shopItems.add(ShopItem(
    name: 'فيسكو 5000',
    itemDisc: " زيت محرك مخلق كلياً عالي الجودة يلبي أحدث متطلبات مواصفات أيه بي آى ، يوصي به العديد من مصنعي السيارات ومناسب لمجموعة كبيرة من المحركات والاستخدامات ، ويعد الاختيار الأمثل لحماية متقدمة في ظروف القيادة الشاقة. ",
    price: 15.0,
    image: -1,
    imageUrl: "https://cargas.com.eg/oils/images/visco500dx.jpg",
    itemCode: "54894848784",
    itemType: 0,
  ));

  shopItems.add(ShopItem(
    name: 'فيسكو 5000 اس ان',
    itemDisc: " ",
    price: 15.0,
    image: -1,
    imageUrl: "https://cargas.com.eg/oils/images/visco5000.png",
    itemCode: "54894848784",
    itemType: 0,
  ));

  shopItems.add(ShopItem(
    name: 'فيسكو 3000 اس ان',
    itemDisc: " زيت محرك مخلق جزئيا عالى الجودة مناسب لجميع المحركات الحديثة ، يقدم أداء عالي الكفاءة وبأقصى درجة. يغطي مجموعة واسعة من الاستخدامات حيث يقدم نظافة فائقة للمحرك وهي التي تحافظ على سيارتك على الطريق لفترة أطول. ",
    price: 15.0,
    image: -1,
    imageUrl: "https://cargas.com.eg/oils/images/nwv3000.png",
    itemCode: "54894848784",
    itemType: 0,
  ));

  shopItems.add(ShopItem(
    name: 'فيسكو 3000 اس ال',
    itemDisc: " زيت محرك معدني عالي الجودة مع تركيبة حماية الدرع الحراري، تؤمن برودة ونظافة المحرك أثناء التشغيل. تُعد محركات اليوم أكثر حرارة أكثر من قبل فإرتفاع درجة حرارة المحرك تعمل على أكسدة الزيت . ",
    price: 15.0,
    image: -1,
    imageUrl: "https://cargas.com.eg/oils/images/visco3000.png",
    itemCode: "54894848784",
    itemType: 0,
  ));

  runApp(const CargasApp());
}

class CargasApp extends StatelessWidget {
  const CargasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ContainerHomePage(title: 'Cargas'),
    );
  }
}


