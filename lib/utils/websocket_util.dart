import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../common/constant.dart';
import 'logger_util.dart';

// websocket 状态
enum SocketStatus {
  socketStatusConnected, //已连接
  sockecStatusFailed,  //失败
  socketStatusClosed, //连接关闭
}

class WebsocketUtil{
  //单例对象
  static final WebsocketUtil _instance = WebsocketUtil._internal();
  //获取单例内部方法
  factory WebsocketUtil() => _instance;
  //内部构造方法, 避免外部暴露构造函数, 进行实例化
  WebsocketUtil._internal(); //私有构造函数（命名构造函数）

  late WebSocketChannel _webSocket; //websocket
  SocketStatus? _socketStatus; //socket状态
  Timer? _heartBeat; //心跳定时器
  final int _heartTimes = 30000; //心跳间隔(毫秒): 3秒
  final int _reconnecCount = 2; //重连次数, 默认60次
  int _reconnecTimes = 0; //重连计数器
  Timer? _reconnecTimer; //重连定时器
  late Function onError; //连接错误回调
  late Function onOpen; //连接开启回调
  late Function onMessage; //接收消息回调

  // 初始化websocket
  void initWebSocket({required Function onOpen, required Function onMessage, required Function onError}) {
    this.onOpen = onOpen;
    this.onMessage = onMessage;
    this.onError = onError;

    // 开启websocket连接
    openSocket();
  }

  // 开启websocket连接
  void openSocket() {
    // 连接成功, 返回websocket实例
    String socket_url = Constant.SOCKET_URL;
    _webSocket = WebSocketChannel.connect(Uri.parse(socket_url));
    logger.i('websocket连接成功: $socket_url');
    _socketStatus = SocketStatus.socketStatusConnected;
    // 连接成功, 重置重连计数器
    _reconnecTimes = 0;
    if (_reconnecTimer != null) {
      _reconnecTimer?.cancel();
      _reconnecTimer = null;
    }
    onOpen();

    //接收消息
    _webSocket.stream.listen((data) => webSocketOnMessage(data), onError: webSocketOnError, onDone: webSocketOnDone);
  }

  // websocket接收消息回调
  webSocketOnMessage(data) {
    onMessage(data);
  }

  // websocket关闭连接回调
  webSocketOnDone() {
    logger.i('webSocketOnDone closed');
    _socketStatus = SocketStatus.socketStatusClosed;
    reconnect();
  }

  // websocket连接错误回调
  webSocketOnError(e) {
    WebSocketChannelException ex = e;
    _socketStatus = SocketStatus.sockecStatusFailed;
    onError(ex.message);
    closeSocket();
  }

  //初始化心跳
  void initHeartBeat() {
    destroyHeartBeat();
    _heartBeat = Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
      sentHeart();
    });
  }

  //心跳
  void sentHeart() {
    sendMessage('~H#C~');
  }

  // 销毁心跳
  void destroyHeartBeat() {
    if(_heartBeat != null) {
      _heartBeat?.cancel();
      _heartBeat = null;
    }
  }

  //关闭websocket
  void closeSocket() {
    logger.i('websocket连接关闭');
    _webSocket.sink.close();
    destroyHeartBeat();
    _socketStatus = SocketStatus.socketStatusClosed;
  }

  //发送websocket消息
  void sendMessage(message) {
    switch(_socketStatus) {
      case SocketStatus.socketStatusConnected:
        logger.i('SENT: $message');
        _webSocket.sink.add(message);
        break;
      case SocketStatus.socketStatusClosed:
        logger.i('连接已关闭');
        break;
      case SocketStatus.sockecStatusFailed:
        logger.i('发送失败');
        break;
      default:
        break;
    }
  }

  // 重连机制
  void reconnect() {
    if (_reconnecTimes < _reconnecCount) {
      _reconnecTimes++;
      _reconnecTimer = Timer.periodic(Duration(milliseconds: _heartTimes), (timer){
        openSocket();
      });
    } else {
      if(_reconnecTimer != null) {
        logger.i('重连次数超过最大次数');
        _reconnecTimer?.cancel();
        _reconnecTimer = null;
      }
      return;
    }
  }

  get socketStatus => _socketStatus;
  get webSocketCloseCode => _webSocket.closeCode;
}