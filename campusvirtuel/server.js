//npm install express path express-fileupload body-parser http socket.io
const express           = require('express');
const path              = require('path');
const fileUpload        = require('express-fileupload');
const bodyParser        = require('body-parser');
const app               = express();
const server            = require('http').createServer(app);
const io                = require('socket.io')(server, {cors: { origin: "*", methods: ["GET", "POST"]}});

const load_data           = require('./servers/load_data');
const loadOneInfo          = require('./servers/load_one_info');
const update_data           = require('./servers/update_data');
const insert_data           = require('./servers/insert_data');

app.use(bodyParser.json());//accept json params
app.use(bodyParser.urlencoded({extended: true})); //accept url encodes params
app.use(fileUpload());
app.use(express.static('public'));
app.get('/',(request, response, next)=>{
   
    response.sendFile(path.join(__dirname+'/client/index.html'));
});
app.post('/request', (request, response)=>{
    console.log("well")
    let data = JSON.parse(request.body.data);
    load_data.loadData(data, response);
});
app.post('/request_one_info', (request, response)=>{
    let data = JSON.parse(request.body.data);
    
    loadOneInfo.loadOneInfo(data, response);
});

app.post('/request_native', (request, response)=>{
    response.header("Access-Control-Allow-Origin", "*");
    response.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    load_data.loadData(request.body, response);
});
app.post("/insert_update", (request, response)=>{
    let allInfo = JSON.parse(request.body.all_infos);
    if(allInfo.is_update_insert === "update") update_data.updateData(allInfo.table, allInfo.data, request.files, __dirname , response);
    else insert_data.insertData(allInfo.table, allInfo.data, request.files, __dirname, response);

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