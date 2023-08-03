import 'package:brocker/const.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class WebSocketHelper {
  static late IO.Socket socket;
  static initWebSocket() {
    print(token);
    socket = IO.io(
        'http://10.0.2.2:4000/sockets/chats',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'auth': token}) // optional
            .build()

        // {

        // 'transports': ['websocket'],

        // 'debug': true,
        // Enable debugging
        // }
        );
    socket.connect();

    // socket.io.options['extraHeaders'] = {
    //   'auth':'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MzVkMjQ5ZjM4NzY0YmY5ODBhODI5MyIsImVtYWlsIjoia2hhbGVkMTIzQGdtYWlsLmNvbSIsInVzZXJuYW1lIjoia2hhbGVkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1MTEwNTM3LCJleHAiOjE2ODUxOTY5Mzd9.ImaSH2Hhj852IFcMM9wCvXPA_YwAHPAG0p0ErMIR2RQ'
    // ,
    // 'transports': ['websocket'],

    //   'debug': true,
    // };

    socket.onConnect((data) {
      print('Connection established');

      // socket.emit("joinChat",{
      //  "chatId": "6470da52ed40390b365b23f8",
      // });
    });
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect((data) => print('Socket.IO server disconnected'));

    // socket.on('sendMessage', (data) {
    //   print(data);
    // });
  }

  static sendMessage({
    required String otherUserId,
    required String chatId,
    required String message,
  }) {
    socket.emit("sendMessage", {
      "content": {
        "otherUserId": otherUserId,
        "chatId": chatId,
        "message": message
      }
    });
  }
}
