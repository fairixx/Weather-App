import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sdp_transform/sdp_transform.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _checkOffer = false;
  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  //	late	MediaStreamTrack	_localStream;
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  final TextEditingController _sdpController = TextEditingController();
  Future<void> requestPermissions() async {
    //	const	cameraPermission	=	Permission.camera;
    //	const	microphonePermission	=	Permission.microphone;
    await [Permission.camera, Permission.microphone];
    //	if	(await	permission.isDenied)	{
    //			await	permission.request();
    //	}
    //	}
  }

  Future<bool> checkPermissionStatus() async {
    const permission = Permission.camera;
    return await permission.status.isGranted;
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _sdpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    requestPermissions();
    initRendereres();
    _createPeerConnection().then((pc) {
      _peerConnection = pc;
    });
    //	_getUserMedia();
    super.initState();
  }

  initRendereres() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  _createPeerConnection() async {
    Map<String, dynamic> configuration = {
      'sdpSemantics': 'uinified-plan',
      'icsServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ]
    };
    Map<String, dynamic> offerSdpConstraints = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': true,
      },
      'optional': [],
    };
    _localStream = await _getUserMedia();
    RTCPeerConnection pc =
        await createPeerConnection(configuration, offerSdpConstraints);
    //	pc.addStream(_localStream);	//////before:	user	both	local	and	remote	after	vid2,	//
    //	pc.addTrack(_localStream	as	MediaStreamTrack);//worked	but	shows	error
    _localStream.getTracks().forEach((track) {
      pc.addTrack(track, _localStream);
    });
    //define	events	for	connection
    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print(json.encode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString(),
          'sdpMlineIndex': e.sdpMLineIndex,
        }));
      }
    };
    pc.onIceConnectionState = (e) {
      print(e);
    };
    //	pc.onAddStream	=	(stream)	{//////before:	user	both	local	and	remote	a...
    pc.onAddTrack = (stream, track) {
      print('addStream	${stream.id}');
      _remoteRenderer.srcObject =
          stream; //receiveing	the	stream	and	assign	it	to	remote	render
    };
    return pc;
  }

  void _openCamera() async {}
  _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video':
          //	true,
          {
        'facingMode': 'user',
        //	'facingMode':	'environment',
      },
    };
    //	MediaStream	stream	=	await	navigator.getUserMedia(mediaConstraints);
    final stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    setState(() {
      _localRenderer.srcObject = stream;
    });
    return stream;
  }

  void _createOffer() async {
    print('inside	create	offer');
    RTCSessionDescription description =
        await _peerConnection.createOffer({'offerToReceiveVideo': 1});
    print('hey1');
    var session = parse(description.sdp.toString()); //////////////
    print('hey2');
    print('ffffff');
    print(json.encode(session)); //pot	this	in	terminal
    print('\n\nhey3');
    _checkOffer = true;
    _peerConnection.setLocalDescription(description);
    print('hey4');
  }

  void _createAnswer() async {
    print('in	create	answer');
    RTCSessionDescription description =
        await _peerConnection.createAnswer({'offerToReceiveVideo': 1});
    print('hey11');
    var session = parse(description.sdp!); /////////
    print('hey22');
    print(json.encode(session));
    print('hey33');
    _peerConnection.setLocalDescription(description);
    print('hey44');
  }

  void setRemoteDescription() async {
    print('inside	set	remote	description');
    String jsonString = _sdpController.text;
    print('hey111');
    print('jsonString	$jsonString');
    //	jsonString	=	_sdpController.text;
    dynamic session = await jsonDecode(jsonString);
    print('session	$session');
    String sdp = write(session, null);
    print('hey222');
    RTCSessionDescription description =
        RTCSessionDescription(sdp, _checkOffer ? 'answer' : 'offer');
    print('hey333');
    print("desc.	:\n${description.toMap()}");
    print('hey444');
    await _peerConnection.setRemoteDescription(description);
    print('hey555');
  }

  void setCandidate() async {
    print('inside	set	candidate');
    var num = 1;
    String jsonString = _sdpController.text;
    print('11hey');
    if (jsonString.isNotEmpty) {
      dynamic session = await jsonDecode(jsonString);
      print('22hey');
      print(session['candidate']);
      print('33hey');
      dynamic candidate = RTCIceCandidate(
          session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
      print('44hey');
      print('55555hey	\n${candidate.toString()}');
      await _peerConnection.addCandidate(candidate);
      setState(() {
        _peerConnection.addCandidate(candidate);
        RTCVideoView(
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          _remoteRenderer,
          mirror: true,
          filterQuality: FilterQuality.medium,
        );
        RTCVideoView(
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          _localRenderer,
          mirror: false,
          filterQuality: FilterQuality.low,
        );
      });
    }
  }

  //	SizedBox	videoRenderers()	=>	SizedBox(
  //							height:	100,
  //							width:	50,
  //							child:	Container(
  //									key:	const	Key('local'),
  //									//	margin:	,
  //									decoration:	const	BoxDecoration(color:	Colors.black),
  //									child:	RTCVideoView(_localRenderer),
  //							),
  //					);
  //	ignore:	non_constant_identifier_names
  Container offer_answerButtons() {
    return Container(
      //	width:	double.infinity,
      height: 125,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)),
          shape: BoxShape.rectangle,
          color: Color.fromARGB(167, 210, 191, 240)),
      //	color:	Color.fromARGB(181,	238,	238,	238)),
      child: Column(
        children: [
          TextField(
            //sdp	candidate	TF
            controller: _sdpController,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
            maxLength: TextField.noMaxLength,
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  _createOffer();
                }, //_createOffer()
                child: const Text('Offer'),
              ),
              const SizedBox(
                width: 1,
              ),
              TextButton(
                onPressed: () {
                  _createAnswer();
                }, //_createAnswer()
                child: const Text('Answer'),
              ),
              sdp_candidate_buttons(),
            ],
          ),
        ],
      ),
    );
  }

  //	ignore:	non_constant_identifier_names
  Row sdp_candidate_buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: () {
            setRemoteDescription();
          }, //setRemote	Description()
          child: const Text('Set	Remote'),
        ),
        const SizedBox(
          height: 1,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              setCandidate();
            });
            //	setCandidate();
          }, //set	candidate()
          child: const Text('Set	Candidate'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              key: const Key('local'),
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 82, 82, 82)),
              child: RTCVideoView(
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                _localRenderer, //_remoteRenderer
                mirror: true,
                filterQuality: FilterQuality.medium,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2, //550
              right: MediaQuery.of(context).size.width / 2, //300
              left: 10,
              bottom: 5,
              //	width:	200,
              //	height:	150,
              child: Container(
                key: const Key('remote'),
                decoration: const BoxDecoration(color: Colors.black),
                child: RTCVideoView(
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  _remoteRenderer,
                  mirror: false,
                  filterQuality: FilterQuality.low,
                ),
              ),
            ),
            offer_answerButtons(),
            //	sdp_candidate_buttons(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCamera,
        tooltip: 'Camera',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
