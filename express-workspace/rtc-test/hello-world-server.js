'use strict';

var os = require('os');
var nodeStatic = require('node-static');
var http = require('http');
//var https = require('https');
var socketIO = require('socket.io');
var fs = require('fs');

var fileServer = new(nodeStatic.Server)();

var app = http.createServer(function(req, res) {
	console.log("node.JS 시작");
  fileServer.serve(req, res);
}).listen(1337);


//const option = {
//		key : fs.readFileSync('./keys/nodePrivate.pem'),
//		cert : fs.readFileSync('./keys/nodePrivateCSR.pem'),
//};

//var app = https.createServer(option, function(req, res) {
//	  fileServer.serve(req, res);
//	}).listen(1337);

var io = socketIO.listen(app);
io.sockets.on('connection', function(socket) {

  // convenience function to log server messages on the client
  function log() {
    var array = ['Message from server:'];
    array.push.apply(array, arguments);
    socket.emit('log', array);
  }

  /*
  socket.on('message', function(message) {
    log('Client said: ', message);
    // for a real app, would be room-only (not broadcast)
    // 이렇게 하면 보낸사람한테도 보내지나?
    console.log()
    socket.broadcast.emit('message', message);
  });
  */
  
  socket.on('message', function(message) {
	  console.log('message 이벤트를 받았습니다.');
	  console.dir(message);
	  
	  console.dir('나를 포함한 모든 클라이언트에게 메시지 이벤트 전송.')
	  
	  // 나중에 상대방에게 넘겨주는 걸로 바꿔야함.
	  //io.sockets.emit('message', message);
	  socket.broadcast.emit('message', message);
  })

  socket.on('create or join', function(room) {
    log('Received request to create or join room ' + room);

    var clientsInRoom = io.sockets.adapter.rooms[room];
    var numClients = clientsInRoom ? Object.keys(clientsInRoom.sockets).length : 0;
    log('Room ' + room + ' now has ' + numClients + ' client(s)');

    if (numClients === 0) {
      socket.join(room);
      log('Client ID ' + socket.id + ' created room ' + room);
      socket.emit('created', room, socket.id);

    } else if (numClients === 1) {
      log('Client ID ' + socket.id + ' joined room ' + room);
      io.sockets.in(room).emit('join', room);
      socket.join(room);
      socket.emit('joined', room, socket.id);
      io.sockets.in(room).emit('ready');
    } else { // max two clients
      socket.emit('full', room);
    }
  });

  socket.on('ipaddr', function() {
    var ifaces = os.networkInterfaces();
    for (var dev in ifaces) {
      ifaces[dev].forEach(function(details) {
        if (details.family === 'IPv4' && details.address !== '127.0.0.1') {
          socket.emit('ipaddr', details.address);
        }
      });
    }
  });

  socket.on('bye', function(){
    console.log('received bye');
  });

});
