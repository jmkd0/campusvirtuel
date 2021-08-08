import {Controller} from '../controller/index.js'; 
//import '/node_modules/@ionic/core/dist/ionic/ionic.esm.js';
document.addEventListener('deviceready', onDeviceReady, false);

class View{
    constructor(){
        this.controller = new Controller();
        this.initView()
    }
    initView(){
        this.controller.init()
        let buttonInstitution = document.getElementById("request_data");
        buttonInstitution.addEventListener('click', ()=>{
            this.getInstitution();
        });
        
        let buttonData = document.getElementById("send_data");
        buttonData.addEventListener('click', ()=>{
            this.getRemoteData();
        });

        document.getElementById("butt_inst").addEventListener('click', ()=>{
            let homeContent = document.getElementById("home_content");
            let institutionContent = document.getElementById("institution_content");
            let inputPseudo = document.getElementById("pseudo");
            let pseudo = inputPseudo.value;
            console.log(pseudo)
            homeContent.style.display = 'none';
            institutionContent.style.display = 'block';
            

            let promise = new Promise((resolve, reject)=>{
                this.controller.getInstitution(resolve);
            });
            promise.then((institutions)=>{
                this.displayInstitutions(institutions);
            });
          });
        document.getElementById("back_inst").addEventListener('click', ()=>{
            let homeContent = document.getElementById("home_content");
            let institutionContent = document.getElementById("institution_content");
            let institutionGrid = document.getElementById("institution_grid");
            institutionContent.style.display = 'none';
            this.deleteChilds(institutionGrid);
            homeContent.style.display = 'block';
            
          });
    }
    displayInstitutions(institutions){
        let institutionGrid = document.getElementById("institution_grid");
        let path = null;
        if(device.platform == "Android"){
            path = cordova.file.applicationDirectory+"www/";
        } else path = "../"
        let ionGrid = document.createElement("ion-grid");
        let instLength = institutions.length;
        let length = (instLength % 2 == 0)? Math.floor(instLength/2) : Math.floor(instLength/2) +1;
        console.log(length)
        for(let i=0; i < length; i++){
          let ionRow = document.createElement("ion-row");
          for(let j=0; j<2; j++){
            let ionCol = document.createElement("ion-col");
            if(2*i+j < instLength){
                ionCol.innerHTML = `
                <ion-card>
                    <ion-card-header>
                    <img src="`+path+`img/`+institutions[2*i+j].getLogoName()+`" class="inst_logo">
                    </ion-card-header>
                    <ion-card-content>
                    <ion-card-title>`+institutions[2*i+j].getName()+`</ion-card-title>
                    <ion-card-subtitle>L'autre approche</ion-card-subtitle>
                    </ion-card-content>
                </ion-card>`;
            }
            ionRow.appendChild(ionCol);
          }
          ionGrid.appendChild(ionRow);
        }
        institutionGrid.appendChild(ionGrid);
    }
    getInstitution(){
        console.log("why you call me")
        let promise = new Promise((resolve, reject)=>{
            this.controller.getInstitution(resolve);
        });
        promise.then((institutions)=>{
            let dataContainer = document.getElementById("local_data_container");
            dataContainer.innerHTML = "The name is: "+institutions.getName()+" and full name "+institutions.getFullName();
            console.log("The name is: "+institutions.getName()+" and full name "+institutions.getFullName());
        });
        
        
    }
    getRemoteData(){
    
        let dataContainer = document.getElementById("remote_data_container");
        //let url = 'http://192.168.0.23:3000/request_native'
        let url = 'https://jsonplaceholder.typicode.com/posts'
        let request_data = {
            parents:  ['1'],   
            table: 'structure'
        };
        cordova.plugin.http.post(url, request_data, {}, function(response) {
            data =  JSON.parse(response.data)
            alert(JSON.stringify(data))
            dataContainer.innerHTML = JSON.stringify(data)
            /*dataContainer.innerHTML = "data: "+data[0].full_name; */
        }, function(error) {
            alert(JSON.stringify(error))
            console.log(error);
        });
    
    }
    deleteChilds(element){
        var first = element.firstElementChild;
        while (first) {
            first.remove();
            first = element.firstElementChild;
        }
    }
}

function onDeviceReady(){
    let vue = new View()
}
