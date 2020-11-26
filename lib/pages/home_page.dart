import 'package:flutter/material.dart';
import 'package:minimarket/util/constants.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _count = 47;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UPN'),
          backgroundColor: primaryColor,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network(
                  "https://faros.hsjdbcn.org/sites/default/files/styles/shareimg/public/campamento-de-verano.jpg?itok=v2DBBDp3"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Oeschinen Lake",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Kandersteg, Switzerland",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _count++;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("$_count")
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.phone,
                      size: 35,
                      color: primaryColor,
                    ),
                    onPressed: () => print("Phone"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.gps_fixed,
                      size: 35,
                      color: primaryColor,
                    ),
                    onPressed: () => print("GPS"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 35,
                      color: primaryColor,
                    ),
                    onPressed: () => print("Share"),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Oeschinen Lake (German: Oeschinensee) is a lake in the Bernese Oberland, Switzerland, 4 kilometres (2.5 mi) east of Kandersteg in the Oeschinen valley. At an elevation of 1,578 metres (5,177 ft), it has a surface area of 1.1147 square kilometres (0.4304 sq mi). Its maximum depth is 56 metres (184 ft). The lake is fed through a series of mountain creeks and drains underground. The water then resurfaces as the Oeschibach.",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ));
  }
}
