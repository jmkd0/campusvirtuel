const socket = io.connect('http://localhost:3000');
let pseudo = "Jean-Marie_m";
socket.emit('request', pseudo); 

socket.on('response', (response)=>{
    console.log(response);
}); 

