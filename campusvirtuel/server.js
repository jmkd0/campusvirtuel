const express           = require('express');
const path              = require('path');
const bodyParser        = require('body-parser');
const app               = express();
const server            = require('http').createServer(app);
const io                = require('socket.io')(server, {cors: { origin: "*", methods: ["GET", "POST"]}});

const load_data           = require('./servers/load_data');

app.use(bodyParser.json());//accept json params
app.use(bodyParser.urlencoded({extended: true})); //accept url encodes params
app.use(express.static('public'));
app.get('/',(request, response, next)=>{
   
    response.sendFile(path.join(__dirname+'/client/index.html'));
});
app.post('/request', (request, response)=>{
    load_data.loadData(request.body, response);
});

app.post('/request_native', (request, response)=>{
    response.header("Access-Control-Allow-Origin", "*");
    response.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    load_data.loadData(request.body, response);

});


io.on('connection', function (socket) { 
    let send_to_client='You are connected!: ';
    socket.on('request', function(get_from_client) {
        send_to_client = send_to_client+get_from_client;
        console.log("Hello :"+ get_from_client);				//save pseudo 
        io.emit('response', send_to_client);   	//Emit message to the caller 
        
    }); 

});
server.listen(3000);