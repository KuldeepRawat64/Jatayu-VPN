import 'dart:async';
import 'dart:developer';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:jatayuvpn/core/models/dnsConfig.dart';
import 'package:jatayuvpn/core/models/vpnConfig.dart';
import 'package:jatayuvpn/core/models/vpnStatus.dart';
import 'package:jatayuvpn/core/utils/vpn_engine.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../core/utils/utils.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _vpnState = Vpn.vpnDisconnected;
  List<VpnConfig> _listVpn = [];
  VpnConfig _selectedVpn;
  StreamSubscription<VpnStatus> _streamSubscription;
 
  @override
  void initState() {
    super.initState();

    ///Add listener to update vpnstate
    Vpn.vpnStageSnapshot().listen((event) {
      setState(() {
        _vpnState = event;
      });
    });

    ///Call initVpn
    initVpn();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  ///Here you can start fill the listVpn, for this simple app, i'm using free vpn from https://www.vpngate.net/
  void initVpn() async {
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/us.ovpn"),
        name: "United States"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/japan.ovpn"),
        name: "Japan"));

    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/korea.ovpn"),
        name: "Korea"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/india.ovpn"),
        name: "India"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/vietnam.ovpn"),
        name: "Vietnam"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/austria.ovpn"),
        name: "Austria"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/norway.ovpn"),
        name: "Norway"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/russia.ovpn"),
        name: "Russia"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/thailand.ovpn"),
        name: "Thailand"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/hongkong.ovpn"),
        name: "Hong Kong"));

    if (mounted)
      setState(() {
        _selectedVpn = _listVpn.first;
      });
  }

  _selectedFlag() {
    if (_selectedVpn == null) {
      return CircleAvatar(
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'United States') {
      return CircleAvatar(
        backgroundImage: AssetImage(usFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Japan') {
      return CircleAvatar(
        backgroundImage: AssetImage(japanFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Korea') {
      return CircleAvatar(
        backgroundImage: AssetImage(koreaFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Vietnam') {
      return CircleAvatar(
        backgroundImage: AssetImage(vietnamFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Austria') {
      return CircleAvatar(
        backgroundImage: AssetImage(austriaFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'India') {
      return CircleAvatar(
        backgroundImage: AssetImage(indiaFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Russia') {
      return CircleAvatar(
        backgroundImage: AssetImage(russiaFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Hong Kong') {
      return CircleAvatar(
        backgroundImage: AssetImage(hongkongFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Thailand') {
      return CircleAvatar(
        backgroundImage: AssetImage(thailandFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else if (_selectedVpn.name == 'Norway') {
      return CircleAvatar(
        backgroundImage: AssetImage(norwayFlag),
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    } else {
      return CircleAvatar(
        radius: 40,
        backgroundColor: Colors.transparent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF074A85),
      // appBar: AppBar(
      //   title: Text("OpenVPN"),
      // ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: [
                  upperCurvedContainer(context),
                  circularButtonWidget(
                      context, MediaQuery.of(context).size.width)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
              ),
              // connectedStatusText(),
              Center(
                child: Text(
                  '$_vpnState',
                  style: _vpnState == Vpn.vpnConnected
                      ? connectedGreenStyle
                      : disconnectedRedStyle,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Center(
                child: FlatButton(
                  //  shape: StadiumBorder(),
                  child: Icon(
                    MdiIcons.power,
                    size: MediaQuery.of(context).size.height * 0.09,
                    color: Colors.white,
                  ),
                  onPressed: _connectClick,
                  //   color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SingleChildScrollView(
                child: Container(
                  color: Color(0XFF11273B),
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _listVpn.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              ListTile(
                                  onTap: () {
                                    if (_selectedVpn == _listVpn[index]) return;
                                    log("${_listVpn[index].name} is selected");
                                    Vpn.stopVpn();
                                    setState(() {
                                      _selectedVpn = _listVpn[index];
                                    });
                                  },
                                  leading: _selectedVpn == _listVpn[index]
                                      ? CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.greenAccent,
                                        )
                                      : CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.grey,
                                        ),
                                  title: Text(
                                    _listVpn[index].name,
                                    style: connectedStyle,
                                  )),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          )),
                ),
              ),
            ]),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   return Scaffold(
  //       backgroundColor: bgColor,
  //       body: ListView(
  //         children: <Widget>[
  //           Stack(
  //             alignment: Alignment.topCenter,
  //             overflow: Overflow.visible,
  //             children: <Widget>[
  //               upperCurvedContainer(context),
  //               circularButtonWidget(context, screenWidth),
  //             ],
  //           ),
  //           SizedBox(height: screenWidth * 0.40),
  //           connectedStatusText(),
  //           SizedBox(height: 20),
  //           // We need to pass parameters to this widget
  //           //   locationCard('Random Location',Colors.transparent,kenyaFlagUrl,'Kenya'),

  //           // SizedBox(height: 20),

  //           locationCard(
  //               'Select Location', Colors.indigo[100], usFlag, 'United States'),
  //         ],
  //       ));
  // }

  void _connectClick() {
    ///Stop right here if user not select a vpn
    if (_selectedVpn == null) return;

    if (_vpnState == Vpn.vpnDisconnected) {
      ///Start if stage is disconnected
      Vpn.startVpn(
        _selectedVpn,
        dns: DnsConfig("23.253.163.53", "198.101.242.72"),
      );
    } else {
      ///Stop if stage is "not" disconnected
      Vpn.stopVpn();
    }
  }

  Widget upperCurvedContainer(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 36),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: curveGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // _topRow(),
            Text('Jatayu VPN', style: vpnStyle),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            //  _bottomRow(context),
            StreamBuilder<VpnStatus>(
                stream: Vpn.vpnStatusDurationSnapshot(),
                builder: (context, snapshot) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Download\n${snapshot?.data?.byteIn ?? ""}',
                              style: txtSpeedStyle,
                            ),
                            Text(
                              'Upload\n${snapshot?.data?.byteOut ?? ""}',
                              style: txtSpeedStyle,
                            ),
                          ],
                        ),
                        Text(
                          '${snapshot?.data?.duration ?? ""}',
                          style: connectedSubtitle,
                        ),
                      ],
                    )),
          ],
        ),
      ),
    );
  }

  Widget _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          height: 50,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              Image.asset('assets/premiumcrown.png', height: 36),
              SizedBox(width: 12),
              Text(
                'Go Premium',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.tune,
              size: 26,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _bottomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        StreamBuilder<VpnStatus>(
            //  initialData: VpnStatus(),
            stream: Vpn.vpnStatusDownloadSnapshot(),
            builder: (context, snapshot) => Text(
                  'Download\n${snapshot?.data?.byteIn ?? ""}',
                  style: txtSpeedStyle,
                )),
        StreamBuilder<VpnStatus>(
            //   initialData: VpnStatus(),
            stream: Vpn.vpnStatusUploadSnapshot(),
            builder: (context, snapshot) => Text(
                  'Upload\n${snapshot?.data?.byteOut ?? ""}',
                  style: txtSpeedStyle,
                ))
      ],
    );
  }

  Widget circularButtonWidget(BuildContext context, width) {
    return Positioned(
      bottom: -width * 0.36,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: width * 0.51,
            width: width * 0.51,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: curveGradient,
              // color: Colors.red,
            ),
            child: Center(
              child: Container(
                height: width * 0.4,
                width: width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: bgColor,
                ),
                child: Center(
                  child: Container(
                    height: width * 0.3,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: _vpnState == Vpn.vpnConnected
                            ? greenGradient
                            : redGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0XFF00D58D).withOpacity(.2),
                            spreadRadius: 15,
                            blurRadius: 15,
                          ),
                        ]),
                    child: Center(
                      child: Icon(
                          _vpnState == Vpn.vpnConnected
                              ? Icons.vpn_lock
                              : Icons.public,
                          color: Colors.white,
                          size: 50),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //top left widget
          Positioned(
            left: 8,
            top: 30,
            child: Container(
              padding: EdgeInsets.all(8),
              height: 60,
              width: 60,
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Center(
                child: _selectedFlag(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget connectedStatusText() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(text: 'Status : ', style: connectedStyle, children: [
          TextSpan(
              text: '$_vpnState\n',
              style: _vpnState == Vpn.vpnConnected
                  ? connectedGreenStyle
                  : disconnectedRedStyle),
          // TextSpan(text: '', style: connectedSubtitle),
        ]),
      ),
    );
  }

  Widget locationCard(title, cardBgColor, flag, country) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: locationTitleStyle),
          SizedBox(height: 14.0),
          Container(
            height: 80,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardBgColor,
              border: Border.all(
                color: Color(0XFF9BB1BD),
                style: BorderStyle.solid,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  backgroundImage: AssetImage(flag),
                ),
                title: Text(
                  country,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.refresh,
                  size: 28,
                  color: Colors.white70,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
